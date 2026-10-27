// Lab 6: multithreaded grayscale + Sobel benchmark.
//
// Usage:
//   ./lab6 [video] [frames=30] [repetitions=7] [workers=1,2,3,4,8] [--write-artifacts]
//
// The program keeps Lab 5's fixed-point BT.709 grayscale conversion and
// L1 Sobel magnitude.  It reports a serial baseline and two row-partitioned
// multithreaded pipelines:
//   1. phased: all workers grayscale, synchronize, then all workers Sobel;
//   2. fused: each worker uses a private three-row grayscale window and
//      redundantly converts two halo rows at every worker boundary.
//
// Video decoding, allocation of image buffers and fused-worker scratch space,
// correctness checks, display, and file I/O are outside the timed region.
// Creating/joining std::thread workers remains inside the timed region so its
// overhead is visible in the measurements.

#include <opencv2/opencv.hpp>

#include <algorithm>
#include <chrono>
#include <condition_variable>
#include <cstdlib>
#include <exception>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <mutex>
#include <numeric>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

using Clock = std::chrono::steady_clock;

struct RowRange {
    int begin;
    int end;  // exclusive
};

struct Statistics {
    double medianMs;
    double meanMs;
};

static double median(std::vector<double> values) {
    std::sort(values.begin(), values.end());
    const size_t n = values.size();
    return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2.0;
}

static double mean(const std::vector<double>& values) {
    return std::accumulate(values.begin(), values.end(), 0.0) / values.size();
}

static int positiveArgument(const char* text, const char* name) {
    try {
        const int value = std::stoi(text);
        if (value > 0) return value;
    } catch (const std::exception&) {
    }
    throw std::invalid_argument(std::string(name) + " must be a positive integer");
}

static std::vector<int> parseWorkerCounts(const std::string& text) {
    std::vector<int> counts;
    std::stringstream list(text);
    std::string item;
    while (std::getline(list, item, ',')) {
        if (item.empty()) throw std::invalid_argument("empty worker count");
        counts.push_back(positiveArgument(item.c_str(), "worker count"));
    }
    if (counts.empty()) throw std::invalid_argument("at least one worker count is required");
    std::sort(counts.begin(), counts.end());
    counts.erase(std::unique(counts.begin(), counts.end()), counts.end());
    return counts;
}

static void printUsage(const char* program) {
    std::cout << "Usage: " << program
              << " [video] [frames=30] [repetitions=7] [workers=1,2,3,4,8] [--write-artifacts]\n"
              << "Example: " << program
              << " /home/alec/Downloads/bbb_sunflower_2160p_60fps_normal.mp4 30 7 1,2,3,4,8 --write-artifacts\n";
}

// A simple reusable barrier for the phased pipeline.  C++17 does not provide
// std::barrier, so workers wait here after filling their disjoint gray rows.
class Barrier {
public:
    explicit Barrier(int parties) : parties_(parties) {}

    void arriveAndWait() {
        std::unique_lock<std::mutex> lock(mutex_);
        const int observedGeneration = generation_;
        if (++arrived_ == parties_) {
            arrived_ = 0;
            ++generation_;
            wakeup_.notify_all();
            return;
        }
        wakeup_.wait(lock, [&] { return generation_ != observedGeneration; });
    }

private:
    const int parties_;
    int arrived_ = 0;
    int generation_ = 0;
    std::mutex mutex_;
    std::condition_variable wakeup_;
};

static int workerCountFor(int requested, int rows) {
    CV_Assert(rows > 0);
    return std::max(1, std::min(requested, rows));
}

static RowRange splitRows(int rows, int workerId, int workers) {
    // The multiplication is widened so this also works for unusually tall Mats.
    return {
        static_cast<int>(static_cast<long long>(rows) * workerId / workers),
        static_cast<int>(static_cast<long long>(rows) * (workerId + 1) / workers),
    };
}

// Lab 5's best-performing arithmetic, expressed as reusable row kernels.
// Color is CV_8UC3 in OpenCV's BGR byte order; gray and edges are CV_8UC1.
static void grayscaleRows(const cv::Mat& color, cv::Mat& gray, RowRange rows) {
    CV_Assert(color.type() == CV_8UC3 && gray.type() == CV_8UC1);
    CV_Assert(color.rows == gray.rows && color.cols == gray.cols);
    for (int y = rows.begin; y < rows.end; ++y) {
        const uchar* in = color.ptr<uchar>(y);
        uchar* out = gray.ptr<uchar>(y);
        for (int x = 0; x < color.cols; ++x) {
            const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
                          + 218 * in[3 * x + 2] + 512;
            out[x] = static_cast<uchar>(sum >> 10);
        }
    }
}

// Computes output row y from grayscale input rows y, y+1 and y+2.  This
// retains Lab 5's border policy: output dimensions are (H-2) x (W-2).
static void sobelRows(const cv::Mat& gray, cv::Mat& edges, RowRange rows) {
    CV_Assert(gray.type() == CV_8UC1 && edges.type() == CV_8UC1);
    CV_Assert(edges.rows == gray.rows - 2 && edges.cols == gray.cols - 2);
    for (int y = rows.begin; y < rows.end; ++y) {
        const uchar* a = gray.ptr<uchar>(y);
        const uchar* b = gray.ptr<uchar>(y + 1);
        const uchar* c = gray.ptr<uchar>(y + 2);
        uchar* dst = edges.ptr<uchar>(y);
        for (int x = 0; x < edges.cols; ++x) {
            const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2]
                         - c[x] + c[x + 2];
            const int gy = -a[x] - 2 * a[x + 1] - a[x + 2]
                         + c[x] + 2 * c[x + 1] + c[x + 2];
            const int magnitude = std::abs(gx) + std::abs(gy);
            dst[x] = static_cast<uchar>(std::min(magnitude, 255));
        }
    }
}

static void serialGrayscale(const cv::Mat& color, cv::Mat& gray) {
    grayscaleRows(color, gray, {0, color.rows});
}

static void serialSobel(const cv::Mat& gray, cv::Mat& edges) {
    sobelRows(gray, edges, {0, gray.rows - 2});
}

static void serialPipeline(const cv::Mat& color, cv::Mat& gray, cv::Mat& edges) {
    serialGrayscale(color, gray);
    serialSobel(gray, edges);
}

template <typename Worker>
static void runRowWorkers(int rows, int requestedWorkers, Worker&& worker) {
    const int workers = workerCountFor(requestedWorkers, rows);
    if (workers == 1) {
        worker(0, splitRows(rows, 0, 1));
        return;
    }

    std::vector<std::thread> threads;
    threads.reserve(workers);
    for (int id = 0; id < workers; ++id) {
        const RowRange range = splitRows(rows, id, workers);
        threads.emplace_back([&, id, range] { worker(id, range); });
    }
    for (std::thread& thread : threads) thread.join();
}

static void parallelGrayscale(const cv::Mat& color, cv::Mat& gray, int requestedWorkers) {
    runRowWorkers(color.rows, requestedWorkers,
                  [&](int, RowRange rows) { grayscaleRows(color, gray, rows); });
}

static void parallelSobel(const cv::Mat& gray, cv::Mat& edges, int requestedWorkers) {
    runRowWorkers(gray.rows - 2, requestedWorkers,
                  [&](int, RowRange rows) { sobelRows(gray, edges, rows); });
}

// Shared-gray implementation: the barrier makes every grayscale row visible
// before any worker reads it for Sobel.  Each worker owns disjoint output rows.
static void phasedPipeline(const cv::Mat& color, cv::Mat& gray, cv::Mat& edges,
                           int requestedWorkers) {
    const int workers = workerCountFor(requestedWorkers, color.rows - 2);
    if (workers == 1) {
        serialPipeline(color, gray, edges);
        return;
    }

    Barrier grayComplete(workers);
    std::vector<std::thread> threads;
    threads.reserve(workers);
    for (int id = 0; id < workers; ++id) {
        const RowRange grayRows = splitRows(color.rows, id, workers);
        const RowRange outputRows = splitRows(color.rows - 2, id, workers);
        threads.emplace_back([&, grayRows, outputRows] {
            grayscaleRows(color, gray, grayRows);
            grayComplete.arriveAndWait();
            sobelRows(gray, edges, outputRows);
        });
    }
    for (std::thread& thread : threads) thread.join();
}

// Each fused worker gets a preallocated private three-row buffer.  A band of n
// output rows reads n+2 source rows, but only three grayscale rows are live at
// once because the Sobel window rotates. Neighboring bands repeat exactly two
// grayscale rows, eliminating the phased pipeline's global barrier.
struct FusedScratch {
    cv::Mat grayRows;

    void prepare(int cols) {
        grayRows.create(3, cols, CV_8UC1);
    }
};

static void fusedBand(const cv::Mat& color, cv::Mat& edges, RowRange outputRows,
                      cv::Mat& localGray) {
    const int bandRows = outputRows.end - outputRows.begin;
    CV_Assert(bandRows > 0 && localGray.rows >= 3);
    CV_Assert(localGray.cols == color.cols && localGray.type() == CV_8UC1);

    uchar* above = localGray.ptr<uchar>(0);
    uchar* center = localGray.ptr<uchar>(1);
    uchar* below = localGray.ptr<uchar>(2);

    // Prime the local 3-row Sobel window.  The final y is at most H-3, so
    // y+2 stays within the color frame.
    const int first = outputRows.begin;
    const int cols = color.cols;
    auto convertTo = [&](int sourceRow, uchar* destination) {
        const uchar* in = color.ptr<uchar>(sourceRow);
        for (int x = 0; x < cols; ++x) {
            const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
                          + 218 * in[3 * x + 2] + 512;
            destination[x] = static_cast<uchar>(sum >> 10);
        }
    };

    convertTo(first, above);
    convertTo(first + 1, center);
    for (int y = first; y < outputRows.end; ++y) {
        convertTo(y + 2, below);
        uchar* dst = edges.ptr<uchar>(y);
        for (int x = 0; x < edges.cols; ++x) {
            const int gx = -above[x] + above[x + 2] - 2 * center[x]
                         + 2 * center[x + 2] - below[x] + below[x + 2];
            const int gy = -above[x] - 2 * above[x + 1] - above[x + 2]
                         + below[x] + 2 * below[x + 1] + below[x + 2];
            const int magnitude = std::abs(gx) + std::abs(gy);
            dst[x] = static_cast<uchar>(std::min(magnitude, 255));
        }

        uchar* oldest = above;
        above = center;
        center = below;
        below = oldest;
    }
}

static void fusedPipeline(const cv::Mat& color, cv::Mat& edges, int requestedWorkers,
                          std::vector<FusedScratch>& scratch) {
    const int outputRows = color.rows - 2;
    const int workers = workerCountFor(requestedWorkers, outputRows);
    CV_Assert(static_cast<int>(scratch.size()) >= workers);

    runRowWorkers(outputRows, workers, [&](int id, RowRange rows) {
        fusedBand(color, edges, rows, scratch[id].grayRows);
    });
}

static std::vector<cv::Mat> loadFrames(const std::string& path, int count) {
    std::vector<cv::Mat> frames;
    if (!path.empty()) {
        cv::VideoCapture video(path);
        cv::Mat frame;
        while (static_cast<int>(frames.size()) < count && video.read(frame)) {
            if (frame.type() == CV_8UC3) {
                frames.push_back(frame.clone());
            } else if (frame.type() == CV_8UC4) {
                cv::Mat bgr;
                cv::cvtColor(frame, bgr, cv::COLOR_BGRA2BGR);
                frames.push_back(bgr);
            } else if (frame.type() == CV_8UC1) {
                cv::Mat bgr;
                cv::cvtColor(frame, bgr, cv::COLOR_GRAY2BGR);
                frames.push_back(bgr);
            } else {
                throw std::runtime_error("video frames must have 8-bit one, three, or four channels");
            }
        }
        if (frames.empty()) std::cerr << "Could not read video; using deterministic synthetic frames.\n";
    }
    if (frames.empty()) {
        cv::RNG rng(442);
        for (int i = 0; i < count; ++i) {
            cv::Mat frame(720, 1280, CV_8UC3);
            rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
            frames.push_back(frame);
        }
    }
    for (const cv::Mat& frame : frames) {
        if (frame.rows < 3 || frame.cols < 3 || frame.type() != CV_8UC3) {
            throw std::runtime_error("all input frames must be CV_8UC3 and at least 3x3");
        }
    }
    return frames;
}

struct DiffStats {
    long long pixels = 0;
    long long differingPixels = 0;
    long long differencesNearBoundaries = 0;
    int maximumAbsoluteDifference = 0;
};

static std::vector<int> outputBoundaries(int outputRows, int workers) {
    std::vector<int> boundaries;
    for (int worker = 1; worker < workers; ++worker) {
        boundaries.push_back(splitRows(outputRows, worker, workers).begin);
    }
    return boundaries;
}

static bool nearBoundary(int outputRow, const std::vector<int>& boundaries) {
    for (int boundary : boundaries) {
        // Include the last row owned by one worker and the first row owned by
        // its neighbor, plus one row on either side of that pair.
        if (std::abs(outputRow - boundary) <= 1) return true;
    }
    return false;
}

static DiffStats compareImages(const cv::Mat& expected, const cv::Mat& actual,
                               const std::vector<int>& boundaries = {}) {
    CV_Assert(expected.size() == actual.size() && expected.type() == actual.type());
    CV_Assert(expected.type() == CV_8UC1);
    DiffStats stats;
    for (int y = 0; y < expected.rows; ++y) {
        const uchar* expectedRow = expected.ptr<uchar>(y);
        const uchar* actualRow = actual.ptr<uchar>(y);
        for (int x = 0; x < expected.cols; ++x) {
            const int difference = std::abs(static_cast<int>(expectedRow[x])
                                          - static_cast<int>(actualRow[x]));
            stats.maximumAbsoluteDifference = std::max(stats.maximumAbsoluteDifference, difference);
            if (difference != 0) {
                ++stats.differingPixels;
                if (nearBoundary(y, boundaries)) ++stats.differencesNearBoundaries;
            }
        }
    }
    stats.pixels = static_cast<long long>(expected.rows) * expected.cols;
    return stats;
}

static void requireIdentical(const DiffStats& stats, const std::string& description) {
    if (stats.differingPixels != 0) {
        throw std::runtime_error("correctness check failed: " + description
                                 + " (" + std::to_string(stats.differingPixels)
                                 + " pixels differ; max absolute difference "
                                 + std::to_string(stats.maximumAbsoluteDifference) + ")");
    }
}

static DiffStats validateOneImage(const cv::Mat& color, const std::vector<int>& workerCounts,
                                  const std::string& description) {
    cv::Mat referenceGray(color.rows, color.cols, CV_8UC1);
    cv::Mat referenceEdges(color.rows - 2, color.cols - 2, CV_8UC1);
    serialPipeline(color, referenceGray, referenceEdges);

    DiffStats fourWorkerFused;
    for (int requested : workerCounts) {
        const int workers = workerCountFor(requested, color.rows - 2);
        cv::Mat gray(color.rows, color.cols, CV_8UC1);
        cv::Mat stageEdges(color.rows - 2, color.cols - 2, CV_8UC1);
        cv::Mat phasedEdges(color.rows - 2, color.cols - 2, CV_8UC1);
        cv::Mat fusedEdges(color.rows - 2, color.cols - 2, CV_8UC1);
        std::vector<FusedScratch> scratch(workers);
        for (FusedScratch& item : scratch) item.prepare(color.cols);

        parallelGrayscale(color, gray, requested);
        requireIdentical(compareImages(referenceGray, gray), description + ": grayscale, "
                         + std::to_string(requested) + " workers");
        parallelSobel(referenceGray, stageEdges, requested);
        requireIdentical(compareImages(referenceEdges, stageEdges), description + ": Sobel, "
                         + std::to_string(requested) + " workers");
        phasedPipeline(color, gray, phasedEdges, requested);
        requireIdentical(compareImages(referenceEdges, phasedEdges), description
                         + ": phased pipeline, " + std::to_string(requested) + " workers");
        fusedPipeline(color, fusedEdges, requested, scratch);
        const DiffStats fusedStats = compareImages(referenceEdges, fusedEdges,
                                                    outputBoundaries(referenceEdges.rows, workers));
        requireIdentical(fusedStats, description + ": fused pipeline, "
                         + std::to_string(requested) + " workers");
        if (requested == 4) fourWorkerFused = fusedStats;
    }
    return fourWorkerFused;
}

static DiffStats validate(const cv::Mat& color, const std::vector<int>& workerCounts) {
    // Always exercise the course's primary thread counts, even if a user asks
    // the benchmark to print only one count.
    std::vector<int> validationCounts = workerCounts;
    validationCounts.insert(validationCounts.end(), {1, 2, 3, 4, 8});
    std::sort(validationCounts.begin(), validationCounts.end());
    validationCounts.erase(std::unique(validationCounts.begin(), validationCounts.end()),
                           validationCounts.end());

    const DiffStats contiguousFourWorker = validateOneImage(color, validationCounts,
                                                            "contiguous input");

    // A padded ROI proves every kernel honors cv::Mat row stride rather than
    // assuming color rows are tightly packed.
    cv::Mat padded(color.rows + 2, color.cols + 2, CV_8UC3, cv::Scalar::all(0));
    color.copyTo(padded(cv::Rect(1, 1, color.cols, color.rows)));
    const cv::Mat roi = padded(cv::Rect(1, 1, color.cols, color.rows));
    CV_Assert(!roi.isContinuous());
    validateOneImage(roi, validationCounts, "non-contiguous ROI");

    // An odd, small image forces uneven bands and checks the narrowest useful
    // boundary case independently of the video's (usually even) dimensions.
    cv::Mat odd(7, 9, CV_8UC3);
    cv::RNG rng(442);
    rng.fill(odd, cv::RNG::UNIFORM, 0, 256);
    validateOneImage(odd, validationCounts, "7x9 uneven-band input");
    return contiguousFourWorker;
}

template <typename Operation>
static Statistics measure(const std::vector<cv::Mat>& color, int repetitions,
                          Operation&& operation) {
    // One unreported warm-up pass fills caches and starts dynamic frequency
    // control before samples are collected.
    for (size_t i = 0; i < color.size(); ++i) operation(i);

    std::vector<double> samples;
    samples.reserve(repetitions);
    for (int repetition = 0; repetition < repetitions; ++repetition) {
        const auto start = Clock::now();
        for (size_t i = 0; i < color.size(); ++i) operation(i);
        const double ms = std::chrono::duration<double, std::milli>(Clock::now() - start).count()
                        / color.size();
        samples.push_back(ms);
    }
    return {median(samples), mean(samples)};
}

struct FrameBuffers {
    std::vector<cv::Mat> gray;
    std::vector<cv::Mat> stageEdges;
    std::vector<cv::Mat> phasedEdges;
    std::vector<cv::Mat> fusedEdges;
    std::vector<std::vector<FusedScratch>> scratch;

    FrameBuffers(const std::vector<cv::Mat>& color, int requestedWorkers)
        : gray(color.size()), stageEdges(color.size()), phasedEdges(color.size()),
          fusedEdges(color.size()), scratch(color.size()) {
        for (size_t i = 0; i < color.size(); ++i) {
            const int workers = workerCountFor(requestedWorkers, color[i].rows - 2);
            gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
            stageEdges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
            phasedEdges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
            fusedEdges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
            scratch[i].resize(workers);
            for (FusedScratch& item : scratch[i]) {
                item.prepare(color[i].cols);
            }
        }
    }
};

struct ThreadResult {
    int requestedWorkers;
    int activeWorkers;
    Statistics grayscale;
    Statistics sobel;
    Statistics phasedPipeline;
    Statistics fusedPipeline;
};

static void writeSpeedupGraph(const std::vector<ThreadResult>& results, double baselineMs) {
    std::ofstream svg("lab6_speedup.svg");
    if (!svg) throw std::runtime_error("could not create lab6_speedup.svg");

    constexpr int width = 720, height = 450;
    constexpr int left = 70, right = 30, top = 40, bottom = 65;
    constexpr double maxSpeedup = 8.0;
    const int plotWidth = width - left - right;
    const int plotHeight = height - top - bottom;
    const int intervals = std::max(1, static_cast<int>(results.size()) - 1);
    const auto x = [&](int index) {
        return left + index * plotWidth / intervals;
    };
    const auto y = [&](double speedup) {
        return top + static_cast<int>((maxSpeedup - speedup) * plotHeight / maxSpeedup);
    };

    svg << "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"" << width
        << "\" height=\"" << height << "\" viewBox=\"0 0 " << width << " " << height << "\">\n"
        << "<rect width=\"100%\" height=\"100%\" fill=\"white\"/>\n"
        << "<text x=\"" << width / 2 << "\" y=\"24\" text-anchor=\"middle\" "
           "font-family=\"sans-serif\" font-size=\"18\">Lab 6 speedup vs. thread count</text>\n";
    for (int tick = 0; tick <= static_cast<int>(maxSpeedup); ++tick) {
        const int tickY = y(tick);
        svg << "<line x1=\"" << left << "\" y1=\"" << tickY << "\" x2=\""
            << width - right << "\" y2=\"" << tickY
            << "\" stroke=\"#dddddd\"/>\n"
            << "<text x=\"" << left - 10 << "\" y=\"" << tickY + 5
            << "\" text-anchor=\"end\" font-family=\"sans-serif\" font-size=\"12\">"
            << tick << "</text>\n";
    }
    svg << "<line x1=\"" << left << "\" y1=\"" << top << "\" x2=\"" << left
        << "\" y2=\"" << height - bottom << "\" stroke=\"black\"/>\n"
        << "<line x1=\"" << left << "\" y1=\"" << height - bottom << "\" x2=\""
        << width - right << "\" y2=\"" << height - bottom << "\" stroke=\"black\"/>\n";

    svg << "<polyline fill=\"none\" stroke=\"#999999\" stroke-width=\"2\" stroke-dasharray=\"6 4\" points=\"";
    for (size_t i = 0; i < results.size(); ++i) {
        if (i) svg << " ";
        svg << x(static_cast<int>(i)) << "," << y(results[i].requestedWorkers);
    }
    svg << "\"/>\n<polyline fill=\"none\" stroke=\"#1769aa\" stroke-width=\"3\" points=\"";
    for (size_t i = 0; i < results.size(); ++i) {
        if (i) svg << " ";
        svg << x(static_cast<int>(i)) << ","
            << y(baselineMs / results[i].fusedPipeline.medianMs);
    }
    svg << "\"/>\n";

    svg << std::fixed << std::setprecision(2);
    for (size_t i = 0; i < results.size(); ++i) {
        const int pointX = x(static_cast<int>(i));
        const double speedup = baselineMs / results[i].fusedPipeline.medianMs;
        svg << "<circle cx=\"" << pointX << "\" cy=\"" << y(speedup)
            << "\" r=\"4\" fill=\"#1769aa\"/>\n"
            << "<text x=\"" << pointX << "\" y=\"" << height - bottom + 22
            << "\" text-anchor=\"middle\" font-family=\"sans-serif\" font-size=\"12\">"
            << results[i].requestedWorkers << "</text>\n";
    }
    svg << "<text x=\"" << width / 2 << "\" y=\"" << height - 16
        << "\" text-anchor=\"middle\" font-family=\"sans-serif\" font-size=\"13\">Threads</text>\n"
        << "<text x=\"18\" y=\"" << height / 2
        << "\" transform=\"rotate(-90 18 " << height / 2
        << ")\" text-anchor=\"middle\" font-family=\"sans-serif\" font-size=\"13\">Speedup</text>\n"
        << "<line x1=\"" << width - 190 << "\" y1=\"50\" x2=\"" << width - 160
        << "\" y2=\"50\" stroke=\"#1769aa\" stroke-width=\"3\"/>\n"
        << "<text x=\"" << width - 150 << "\" y=\"54\" font-family=\"sans-serif\" font-size=\"12\">Measured</text>\n"
        << "<line x1=\"" << width - 190 << "\" y1=\"70\" x2=\"" << width - 160
        << "\" y2=\"70\" stroke=\"#999999\" stroke-width=\"2\" stroke-dasharray=\"6 4\"/>\n"
        << "<text x=\"" << width - 150 << "\" y=\"74\" font-family=\"sans-serif\" font-size=\"12\">Ideal</text>\n"
        << "</svg>\n";
}

static cv::Mat representativeFrame(const std::string& videoPath,
                                   const std::vector<cv::Mat>& benchmarkFrames) {
    if (!videoPath.empty()) {
        cv::VideoCapture video(videoPath);
        cv::Mat frame;
        video.set(cv::CAP_PROP_POS_FRAMES, 600);
        if (video.read(frame) && frame.type() == CV_8UC3) return frame.clone();
    }
    // The video may be shorter than 600 frames, or the benchmark may use
    // synthetic input. In either case, retain a real frame already in memory.
    return benchmarkFrames.back();
}

static void writeArtifacts(const std::string& videoPath,
                           const std::vector<cv::Mat>& benchmarkFrames,
                           const std::vector<ThreadResult>& results, double baselineMs) {
    const cv::Mat color = representativeFrame(videoPath, benchmarkFrames);
    cv::Mat serialGray(color.rows, color.cols, CV_8UC1);
    cv::Mat serialEdges(color.rows - 2, color.cols - 2, CV_8UC1);
    cv::Mat fusedEdges(color.rows - 2, color.cols - 2, CV_8UC1);
    serialPipeline(color, serialGray, serialEdges);

    const int workers = workerCountFor(4, color.rows - 2);
    std::vector<FusedScratch> scratch(workers);
    for (FusedScratch& item : scratch) item.prepare(color.cols);
    fusedPipeline(color, fusedEdges, workers, scratch);

    cv::Mat difference;
    cv::absdiff(serialEdges, fusedEdges, difference);
    if (!cv::imwrite("lab6_serial_edges.png", serialEdges)
        || !cv::imwrite("lab6_fused_4_edges.png", fusedEdges)
        || !cv::imwrite("lab6_difference_4.png", difference)) {
        throw std::runtime_error("could not write Lab 6 PNG artifacts");
    }
    writeSpeedupGraph(results, baselineMs);
}

int main(int argc, char** argv) {
    try {
        if (argc > 1 && std::string(argv[1]) == "--help") {
            printUsage(argv[0]);
            return 0;
        }

        const std::string video = argc > 1 ? argv[1] : "";
        const int frameCount = argc > 2 ? positiveArgument(argv[2], "frame count") : 30;
        const int repetitions = argc > 3 ? positiveArgument(argv[3], "repetition count") : 7;
        const std::vector<int> workerCounts = argc > 4
            ? parseWorkerCounts(argv[4]) : std::vector<int>{1, 2, 3, 4, 8};
        const bool writeRequestedArtifacts = argc > 5 && std::string(argv[5]) == "--write-artifacts";
        if (argc > 6 || (argc > 5 && !writeRequestedArtifacts)) {
            throw std::invalid_argument("the optional final argument must be --write-artifacts");
        }

        // The timed pixel loops below contain no OpenCV parallel primitives.
        // Set this explicitly so validation and any incidental OpenCV work also
        // cannot introduce hidden application-level worker threads.
        cv::setNumThreads(1);
        const std::vector<cv::Mat> color = loadFrames(video, frameCount);

        const DiffStats fourWorkerValidation = validate(color.front(), workerCounts);

        FrameBuffers serialBuffers(color, 1);
        const Statistics serialGrayStats = measure(color, repetitions, [&](size_t i) {
            serialGrayscale(color[i], serialBuffers.gray[i]);
        });

        // Precompute the immutable grayscale input outside the Sobel-only timer.
        for (size_t i = 0; i < color.size(); ++i) {
            serialGrayscale(color[i], serialBuffers.gray[i]);
        }
        const Statistics serialSobelStats = measure(color, repetitions, [&](size_t i) {
            serialSobel(serialBuffers.gray[i], serialBuffers.stageEdges[i]);
        });
        const Statistics serialPipelineStats = measure(color, repetitions, [&](size_t i) {
            serialPipeline(color[i], serialBuffers.gray[i], serialBuffers.phasedEdges[i]);
        });

        std::vector<ThreadResult> threaded;
        threaded.reserve(workerCounts.size());
        for (int requested : workerCounts) {
            FrameBuffers buffers(color, requested);  // all image/scratch allocation is untimed
            for (size_t i = 0; i < color.size(); ++i) {
                serialGrayscale(color[i], buffers.gray[i]);
            }

            const Statistics gray = measure(color, repetitions, [&](size_t i) {
                parallelGrayscale(color[i], buffers.gray[i], requested);
            });
            const Statistics sobel = measure(color, repetitions, [&](size_t i) {
                parallelSobel(buffers.gray[i], buffers.stageEdges[i], requested);
            });
            const Statistics phased = measure(color, repetitions, [&](size_t i) {
                phasedPipeline(color[i], buffers.gray[i], buffers.phasedEdges[i], requested);
            });
            const Statistics fused = measure(color, repetitions, [&](size_t i) {
                fusedPipeline(color[i], buffers.fusedEdges[i], requested, buffers.scratch[i]);
            });
            threaded.push_back({requested,
                                workerCountFor(requested, color.front().rows - 2),
                                gray, sobel, phased, fused});
        }

        if (writeRequestedArtifacts) {
            writeArtifacts(video, color, threaded, serialPipelineStats.medianMs);
        }

        std::cout << std::fixed << std::setprecision(3)
                  << "Validated serial, phased, and fused outputs bit-for-bit for "
                     "the first frame, a non-contiguous ROI, and an uneven 7x9 image.\n"
                  << "Fused 4-worker validation: max absolute difference "
                  << fourWorkerValidation.maximumAbsoluteDifference
                  << "; differing pixels " << fourWorkerValidation.differingPixels
                  << " of " << fourWorkerValidation.pixels
                  << "; differences near output-row boundaries "
                  << (fourWorkerValidation.differencesNearBoundaries == 0 ? "no" : "yes")
                  << " (" << fourWorkerValidation.differencesNearBoundaries << ").\n"
                  << "Frames: " << color.size() << " at " << color.front().cols << "x"
                  << color.front().rows << "; one warm-up + " << repetitions
                  << " timed repetitions; ms/frame.\n"
                  << "Timed region excludes video decode and image/scratch allocation. "
                     "Thread creation and joining are included for threaded modes.\n\n"
                  << "## Part 1: serial baseline\n\n"
                  << "| Stage | Median (ms/frame) | Arithmetic mean (ms/frame) |\n"
                  << "|---|---:|---:|\n"
                  << "| Grayscale | " << serialGrayStats.medianMs << " | " << serialGrayStats.meanMs << " |\n"
                  << "| Sobel | " << serialSobelStats.medianMs << " | " << serialSobelStats.meanMs << " |\n"
                  << "| Grayscale + Sobel | " << serialPipelineStats.medianMs << " | " << serialPipelineStats.meanMs << " |\n\n"
                  << "## Threaded measurements (median)\n\n"
                  << "| Requested workers | Active workers | Gray ms | Gray speedup | Sobel ms | Sobel speedup | "
                     "Phased pipeline ms | Phased speedup | Fused pipeline ms | Fused speedup |\n"
                  << "|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|\n";

        for (const ThreadResult& result : threaded) {
            std::cout << "| " << result.requestedWorkers
                      << " | " << result.activeWorkers
                      << " | " << result.grayscale.medianMs
                      << " | " << serialGrayStats.medianMs / result.grayscale.medianMs << "x"
                      << " | " << result.sobel.medianMs
                      << " | " << serialSobelStats.medianMs / result.sobel.medianMs << "x"
                      << " | " << result.phasedPipeline.medianMs
                      << " | " << serialPipelineStats.medianMs / result.phasedPipeline.medianMs << "x"
                      << " | " << result.fusedPipeline.medianMs
                      << " | " << serialPipelineStats.medianMs / result.fusedPipeline.medianMs << "x |\n";
        }

        std::cout << "\nFused workers own disjoint output-row bands.  A worker owning [a, b) "
                     "converts color rows [a, b+1], then writes only edge rows [a, b). "
                     "At each boundary, two grayscale rows are recomputed instead of shared.\n";
        if (writeRequestedArtifacts) {
            std::cout << "Wrote lab6_serial_edges.png, lab6_fused_4_edges.png, "
                         "lab6_difference_4.png, and lab6_speedup.svg.\n";
        }
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << "\n";
        printUsage(argv[0]);
        return 1;
    }
}
