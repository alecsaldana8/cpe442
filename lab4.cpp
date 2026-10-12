// cpe442 lab 4: memory Hierarchy and data locality
// all arithmetic is the Lab 3 selection and is identical across every
// implementation in this file:
//   grayscale : fixed-point BT.709  Y = (218R + 732G + 74B + 512) >> 10
//   Sobel     : 3x3 kernels, magnitude = min(|Gx| + |Gy|, 255)
//   borders   : skipped; output is (rows-2) x (cols-2)

#include <opencv2/opencv.hpp>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>

using Clock = std::chrono::steady_clock;

static double secondsSince(Clock::time_point start) {
    return std::chrono::duration<double>(Clock::now() - start).count();
}

static double median(std::vector<double> v) {
    std::sort(v.begin(), v.end());
    const size_t n = v.size();
    return (n % 2) ? v[n / 2] : 0.5 * (v[n / 2 - 1] + v[n / 2]);
}

// part 2: memory traversal
//
// The array is one contiguous block laid out in row-major order, exactly
// like a C 2D array: element [r][c] lives at offset (r*N + c). Both
// traversals compute the same index expression and perform the same
// operation (add the element to a 64-bit checksum); only the loop nesting
// order differs.
//
//   row-major    : consecutive accesses are 4 bytes apart
//   column-major : consecutive accesses are N*4 bytes apart

static uint64_t traverseRowMajor(const int32_t* data, int n) {
    uint64_t sum = 0;
    for (int r = 0; r < n; ++r) {
        for (int c = 0; c < n; ++c) {
            sum += static_cast<uint32_t>(data[r * n + c]);
        }
    }
    return sum;
}

static uint64_t traverseColMajor(const int32_t* data, int n) {
    uint64_t sum = 0;
    for (int c = 0; c < n; ++c) {
        for (int r = 0; r < n; ++r) {
            sum += static_cast<uint32_t>(data[r * n + c]);
        }
    }
    return sum;
}

static int runTraversal(int argc, char** argv) {
    std::vector<int> sizes;
    for (int i = 2; i < argc; ++i) sizes.push_back(std::atoi(argv[i]));
    if (sizes.empty()) sizes = {16, 128, 1024, 4096};

    // Every size performs roughly the same number of element visits per
    // trial, so small arrays are traversed many times back-to-back. This
    // keeps each timed region long enough to be well above timer noise.
    const long long targetVisits = 1LL << 26;  // ~67M visits per trial
    const int trials = 5;

    std::cout << "## Part 2: Row-major vs column-major traversal\n\n"
              << "Element type int32_t (4 B). Each trial visits ~"
              << targetVisits << " elements; median of " << trials
              << " trials reported.\n\n";
    std::cout << "| Dimensions | Elements | Size | Stride (col-major) | "
                 "Row-major (ms/pass) | Col-major (ms/pass) | "
                 "Row ns/elem | Col ns/elem | Row-major speedup | Checksum match |\n"
              << "|---|---|---|---|---|---|---|---|---|---|\n";

    for (int n : sizes) {
        const long long elems = static_cast<long long>(n) * n;
        std::vector<int32_t> data(elems);
        // Deterministic, non-trivial contents initialised before timing.
        for (long long i = 0; i < elems; ++i) {
            data[i] = static_cast<int32_t>((i * 2654435761LL) & 0x7fffffff);
        }

        const long long passes = std::max(1LL, targetVisits / elems);
        std::vector<double> rowSamples, colSamples;
        uint64_t rowSum = 0, colSum = 0;

        // Warm-up pass of each (touches pages, trains the TLB).
        traverseRowMajor(data.data(), n);
        traverseColMajor(data.data(), n);

        for (int t = 0; t < trials; ++t) {
            auto start = Clock::now();
            uint64_t s = 0;
            for (long long p = 0; p < passes; ++p) s += traverseRowMajor(data.data(), n);
            rowSamples.push_back(secondsSince(start) / passes);
            rowSum = s / passes;

            start = Clock::now();
            s = 0;
            for (long long p = 0; p < passes; ++p) s += traverseColMajor(data.data(), n);
            colSamples.push_back(secondsSince(start) / passes);
            colSum = s / passes;
        }

        const double rowSec = median(rowSamples);
        const double colSec = median(colSamples);
        const double bytes = static_cast<double>(elems) * sizeof(int32_t);
        char sizeStr[32];
        if (bytes >= 1 << 20) std::snprintf(sizeStr, sizeof sizeStr, "%.1f MiB", bytes / (1 << 20));
        else                  std::snprintf(sizeStr, sizeof sizeStr, "%.1f KiB", bytes / 1024);

        std::printf("| %dx%d | %lld | %s | %d B | %.4f | %.4f | %.3f | %.3f | %.2fx | %s (%llu) |\n",
                    n, n, elems, sizeStr, n * static_cast<int>(sizeof(int32_t)),
                    rowSec * 1e3, colSec * 1e3,
                    rowSec * 1e9 / elems, colSec * 1e9 / elems,
                    colSec / rowSec,
                    rowSum == colSum ? "yes" : "NO",
                    static_cast<unsigned long long>(rowSum));
    }
    std::cout << "\nRow-major speedup = column-major time / row-major time.\n";
    return 0;
}

// Shared per-row kernels (identical arithmetic for every pipeline)

constexpr int GRAY_FIXED_SHIFT = 10;
constexpr int GRAY_FIXED_R = 218;
constexpr int GRAY_FIXED_G = 732;
constexpr int GRAY_FIXED_B = 74;
constexpr int GRAY_FIXED_ROUND = (1 << GRAY_FIXED_SHIFT) / 2;

// Converts one row of interleaved BGR bytes to one row of grayscale.
static void grayRowFixed(const uchar* in, uchar* out, int cols) {
    for (int x = 0; x < cols; ++x) {
        const int B = in[3 * x + 0];
        const int G = in[3 * x + 1];
        const int R = in[3 * x + 2];
        const int sum = R * GRAY_FIXED_R + G * GRAY_FIXED_G + B * GRAY_FIXED_B
                      + GRAY_FIXED_ROUND;
        out[x] = static_cast<uchar>(sum >> GRAY_FIXED_SHIFT);
    }
}

// Computes one Sobel output row from three consecutive grayscale rows.
// Output column x corresponds to input column x+1.
static void sobelRowApprox(const uchar* rowAbove, const uchar* rowCenter,
                           const uchar* rowBelow, uchar* out, int outCols) {
    for (int x = 0; x < outCols; ++x) {
        const int p00 = rowAbove[x];
        const int p01 = rowAbove[x + 1];
        const int p02 = rowAbove[x + 2];
        const int p10 = rowCenter[x];
        const int p12 = rowCenter[x + 2];
        const int p20 = rowBelow[x];
        const int p21 = rowBelow[x + 1];
        const int p22 = rowBelow[x + 2];

        const int gx = (-p00 + p02) + (-2 * p10 + 2 * p12) + (-p20 + p22);
        const int gy = (-p00 - 2 * p01 - p02) + (p20 + 2 * p21 + p22);

        const int magnitude = std::abs(gx) + std::abs(gy);
        out[x] = static_cast<uchar>(std::min(magnitude, 255));
    }
}

// part 1 baseline: full-frame pipeline (color -> full gray Mat -> Sobel)
//
// All output/intermediate Mats are allocated by the caller before the
// timed loop; these functions only write into them.

static void grayFull(const cv::Mat& color, cv::Mat& gray) {
    for (int y = 0; y < color.rows; ++y) {
        grayRowFixed(color.ptr<uchar>(y), gray.ptr<uchar>(y), color.cols);
    }
}

// part 3: pixel-access experiment 
// Both Sobel versions traverse in row-major order, use identical arithmetic
// and border policy, and write the same output. Only the mechanism used to
// reach each pixel differs.

// Row-pointer access: one ptr() call per row, then plain indexing.
static void sobelFullPtr(const cv::Mat& gray, cv::Mat& out) {
    const int outRows = gray.rows - 2;
    const int outCols = gray.cols - 2;
    for (int y = 0; y < outRows; ++y) {
        sobelRowApprox(gray.ptr<uchar>(y), gray.ptr<uchar>(y + 1),
                       gray.ptr<uchar>(y + 2), out.ptr<uchar>(y), outCols);
    }
}

// Individual at() access: one Mat::at() call for every pixel read/written.
static void sobelFullAt(const cv::Mat& gray, cv::Mat& out) {
    const int outRows = gray.rows - 2;
    const int outCols = gray.cols - 2;
    for (int y = 0; y < outRows; ++y) {
        for (int x = 0; x < outCols; ++x) {
            const int p00 = gray.at<uchar>(y,     x);
            const int p01 = gray.at<uchar>(y,     x + 1);
            const int p02 = gray.at<uchar>(y,     x + 2);
            const int p10 = gray.at<uchar>(y + 1, x);
            const int p12 = gray.at<uchar>(y + 1, x + 2);
            const int p20 = gray.at<uchar>(y + 2, x);
            const int p21 = gray.at<uchar>(y + 2, x + 1);
            const int p22 = gray.at<uchar>(y + 2, x + 2);

            const int gx = (-p00 + p02) + (-2 * p10 + 2 * p12) + (-p20 + p22);
            const int gy = (-p00 - 2 * p01 - p02) + (p20 + 2 * p21 + p22);

            const int magnitude = std::abs(gx) + std::abs(gy);
            out.at<uchar>(y, x) = static_cast<uchar>(std::min(magnitude, 255));
        }
    }
}

static void pipelineFull(const cv::Mat& color, cv::Mat& gray, cv::Mat& out) {
    grayFull(color, gray);
    sobelFullPtr(gray, out);
}

// part 5: streaming pipeline (color rows -> 3 gray row buffers -> Sobel row)
// rowBuf is a caller-allocated 3 x cols CV_8UC1 Mat, reused every frame.
// The three row pointers rotate logically; no row data is ever copied.
//
// Invariant at the top of iteration y (output row y = input row y+1):
//   above  holds gray row y
//   center holds gray row y+1
//   below  is free and receives gray row y+2
// After computing output row y, gray row y (in `above`) has had its last
// use, so that buffer becomes the next `below`.

static void pipelineStreaming(const cv::Mat& color, cv::Mat& rowBuf, cv::Mat& out) {
    const int cols = color.cols;
    const int outRows = color.rows - 2;
    const int outCols = cols - 2;

    uchar* above  = rowBuf.ptr<uchar>(0);
    uchar* center = rowBuf.ptr<uchar>(1);
    uchar* below  = rowBuf.ptr<uchar>(2);

    // Prime the window with the first two gray rows.
    grayRowFixed(color.ptr<uchar>(0), above, cols);
    grayRowFixed(color.ptr<uchar>(1), center, cols);

    for (int y = 0; y < outRows; ++y) {
        grayRowFixed(color.ptr<uchar>(y + 2), below, cols);
        sobelRowApprox(above, center, below, out.ptr<uchar>(y), outCols);

        uchar* oldest = above;
        above  = center;
        center = below;
        below  = oldest;
    }
}

// output comparison

struct DiffStats {
    long long differing = 0;
    int maxAbsDiff = 0;
    long long pixels = 0;
    bool identical() const { return differing == 0; }
};

static DiffStats compareImages(const cv::Mat& a, const cv::Mat& b) {
    CV_Assert(a.size() == b.size() && a.type() == CV_8UC1 && b.type() == CV_8UC1);
    DiffStats s;
    for (int y = 0; y < a.rows; ++y) {
        const uchar* ra = a.ptr<uchar>(y);
        const uchar* rb = b.ptr<uchar>(y);
        for (int x = 0; x < a.cols; ++x) {
            const int d = std::abs(static_cast<int>(ra[x]) - static_cast<int>(rb[x]));
            if (d) ++s.differing;
            s.maxAbsDiff = std::max(s.maxAbsDiff, d);
        }
    }
    s.pixels = static_cast<long long>(a.rows) * a.cols;
    return s;
}

static void accumulate(DiffStats& total, const DiffStats& s) {
    total.differing += s.differing;
    total.maxAbsDiff = std::max(total.maxAbsDiff, s.maxAbsDiff);
    total.pixels += s.pixels;
}

static std::string describe(const DiffStats& s) {
    char buf[160];
    std::snprintf(buf, sizeof buf, "%lld differing of %lld, max abs diff %d, bit-identical: %s",
                  s.differing, s.pixels, s.maxAbsDiff, s.identical() ? "yes" : "NO");
    return buf;
}

static int runCompare(int argc, char** argv) {
    if (argc < 4) {
        std::cerr << "Usage: " << argv[0] << " compare a.png b.png\n";
        return 1;
    }
    cv::Mat a = cv::imread(argv[2], cv::IMREAD_GRAYSCALE);
    cv::Mat b = cv::imread(argv[3], cv::IMREAD_GRAYSCALE);
    if (a.empty() || b.empty() || a.size() != b.size()) {
        std::cerr << "Images missing or different sizes\n";
        return 1;
    }
    std::cout << describe(compareImages(a, b)) << "\n";
    return 0;
}

// pipeline benchmark driver (Parts 1, 3, 4, 6)

// Loads `count` frames at native resolution, skipping the video's fade-in.
// Falls back to deterministic synthetic noise if no video is available.
static std::vector<cv::Mat> loadSourceFrames(const std::string& path, int count) {
    std::vector<cv::Mat> frames;
    if (!path.empty()) {
        cv::VideoCapture cap(path);
        if (cap.isOpened()) {
            cap.set(cv::CAP_PROP_POS_FRAMES, 600);
            cv::Mat f;
            while (static_cast<int>(frames.size()) < count && cap.read(f)) {
                frames.push_back(f.clone());
            }
        }
        if (frames.empty()) std::cerr << "Could not read " << path << "; using synthetic frames\n";
    }
    if (frames.empty()) {
        cv::RNG rng(442);
        for (int i = 0; i < count; ++i) {
            cv::Mat f(2160, 3840, CV_8UC3);
            rng.fill(f, cv::RNG::UNIFORM, 0, 256);
            frames.push_back(f);
        }
    }
    return frames;
}

struct Resolution { int w, h; const char* name; };

static int runPipeline(int argc, char** argv) {
    const std::string path = (argc > 2) ? argv[2] : "";
    const int frameCount = (argc > 3) ? std::atoi(argv[3]) : 5;
    const int reps = (argc > 4) ? std::atoi(argv[4]) : 5;

    const std::vector<Resolution> resolutions = {
        {320, 180, "180p"},
        {1280, 720, "720p"},
        {1920, 1080, "1080p"},
        {3840, 2160, "2160p (4K)"},
        {7680, 4320, "4320p (8K)"},
    };

    std::vector<cv::Mat> source = loadSourceFrames(path, frameCount);
    std::cout << "Source: " << (path.empty() ? "synthetic" : path) << ", "
              << source.size() << " frames at " << source[0].cols << "x"
              << source[0].rows << "; " << reps
              << " timed repetitions per implementation (median reported).\n"
              << "Timed region: only the grayscale/Sobel computation on frames "
                 "already in memory; buffers are allocated beforehand and "
                 "decode, resize, display and file output are excluded.\n\n";

    // Row accumulators for the final markdown tables.
    std::vector<std::string> accessRows, streamRows, memRows, correctRows;

    for (const Resolution& res : resolutions) {
        // ---- Setup (untimed): scale inputs and allocate every buffer ----
        std::vector<cv::Mat> color(source.size());
        for (size_t i = 0; i < source.size(); ++i) {
            const bool down = res.w < source[i].cols;
            cv::resize(source[i], color[i], cv::Size(res.w, res.h), 0, 0,
                       down ? cv::INTER_AREA : cv::INTER_LINEAR);
        }
        const int W = res.w, H = res.h;
        const long long outPixels = static_cast<long long>(W - 2) * (H - 2);

        // Precomputed grayscale frames so Part 3 times the Sobel stage alone.
        std::vector<cv::Mat> grayIn(color.size());
        for (size_t i = 0; i < color.size(); ++i) {
            grayIn[i].create(H, W, CV_8UC1);
            grayFull(color[i], grayIn[i]);
        }

        cv::Mat grayWork(H, W, CV_8UC1);        // baseline intermediate frame
        cv::Mat rowBuf(3, W, CV_8UC1);          // streaming intermediate rows
        cv::Mat outAt(H - 2, W - 2, CV_8UC1);
        cv::Mat outPtr(H - 2, W - 2, CV_8UC1);
        cv::Mat outFull(H - 2, W - 2, CV_8UC1);
        cv::Mat outStream(H - 2, W - 2, CV_8UC1);

        // ---- Correctness (untimed) ----
        DiffStats atVsPtr, fullVsStream;
        for (size_t i = 0; i < color.size(); ++i) {
            sobelFullAt(grayIn[i], outAt);
            sobelFullPtr(grayIn[i], outPtr);
            accumulate(atVsPtr, compareImages(outAt, outPtr));

            pipelineFull(color[i], grayWork, outFull);
            pipelineStreaming(color[i], rowBuf, outStream);
            accumulate(fullVsStream, compareImages(outFull, outStream));

            if (i == 0) {
                // Preserve the baseline output for later comparisons.
                const std::string tag = std::to_string(W) + "x" + std::to_string(H);
                cv::imwrite("lab4_baseline_" + tag + ".png", outFull);
                cv::imwrite("lab4_streaming_" + tag + ".png", outStream);
            }
        }

        // Stride check: run on a non-continuous ROI whose rows are padded
        // (step > cols*channels), verifying that ptr()-based code honours
        // the real row stride rather than assuming a packed array.
        {
            cv::Mat roi = color[0](cv::Rect(1, 1, W - 3, H - 3));
            CV_Assert(!roi.isContinuous());
            cv::Mat g(roi.size(), CV_8UC1), rb(3, roi.cols, CV_8UC1);
            cv::Mat o1(roi.rows - 2, roi.cols - 2, CV_8UC1), o2 = o1.clone(), o3 = o1.clone();
            pipelineFull(roi, g, o1);
            pipelineStreaming(roi, rb, o2);
            sobelFullAt(g, o3);
            CV_Assert(compareImages(o1, o2).identical() && compareImages(o1, o3).identical());
        }

        // ---- Timed measurements ----
        // Implementations are interleaved within each repetition so that
        // thermal or background-load drift affects them equally.
        enum { AT, PTR, FULL, STREAM, N_IMPL };
        std::vector<std::vector<double>> samples(N_IMPL);

        auto timeAll = [&](int impl) {
            const auto start = Clock::now();
            for (size_t i = 0; i < color.size(); ++i) {
                switch (impl) {
                    case AT:     sobelFullAt(grayIn[i], outAt); break;
                    case PTR:    sobelFullPtr(grayIn[i], outPtr); break;
                    case FULL:   pipelineFull(color[i], grayWork, outFull); break;
                    case STREAM: pipelineStreaming(color[i], rowBuf, outStream); break;
                }
            }
            return secondsSince(start) / color.size();
        };

        for (int impl = 0; impl < N_IMPL; ++impl) timeAll(impl);  // warm-up
        for (int r = 0; r < reps; ++r) {
            for (int impl = 0; impl < N_IMPL; ++impl) samples[impl].push_back(timeAll(impl));
        }

        double ms[N_IMPL], nsPerPx[N_IMPL];
        for (int impl = 0; impl < N_IMPL; ++impl) {
            const double sec = median(samples[impl]);
            ms[impl] = sec * 1e3;
            nsPerPx[impl] = sec * 1e9 / outPixels;
        }

        char line[512];
        std::snprintf(line, sizeof line,
                      "| %s | %dx%d | %.3f | %.3f | %.3f | %.3f | %.2fx |",
                      res.name, W, H, ms[AT], nsPerPx[AT], ms[PTR], nsPerPx[PTR],
                      ms[AT] / ms[PTR]);
        accessRows.push_back(line);

        const double grayKiB = W * H / 1024.0;
        const double rowsKiB = 3.0 * W / 1024.0;
        std::snprintf(line, sizeof line,
                      "| %s | %dx%d | %.1f KiB | %.2f | %.3f | %.2f KiB | %.2f | %.3f | %.3fx |",
                      res.name, W, H, grayKiB, ms[FULL], nsPerPx[FULL],
                      rowsKiB, ms[STREAM], nsPerPx[STREAM], ms[FULL] / ms[STREAM]);
        streamRows.push_back(line);

        // Part 4: minimum bytes moved to/from Mat objects per frame,
        // assuming every byte is touched exactly once (perfect reuse of the
        // 3x3 neighbourhood) and ignoring cache-line granularity.
        const double colorB = 3.0 * W * H, grayB = 1.0 * W * H, outB = outPixels;
        const double baseRead = colorB + grayB, baseWrite = grayB + outB;
        const double naiveGrayLoads = 8.0 * outPixels;  // 8 neighbour loads per output
        std::snprintf(line, sizeof line,
                      "| %s | %.2f MB | %.2f MB | %.2f MB | %.2f MB | %.2f MB | %.2f MB | %.1f KB |",
                      res.name, colorB / 1e6, grayB / 1e6, outB / 1e6,
                      baseRead / 1e6, baseWrite / 1e6, naiveGrayLoads / 1e6, 3.0 * W / 1e3);
        memRows.push_back(line);

        correctRows.push_back(std::string("| ") + res.name + " | at vs ptr | " + describe(atVsPtr) + " |");
        correctRows.push_back(std::string("| ") + res.name + " | full vs streaming | " + describe(fullVsStream) + " |");

        std::cerr << "done " << res.name << "\n";
    }

    std::cout << "## Part 3: Sobel pixel-access mechanism (grayscale precomputed)\n\n"
              << "| Resolution | Size | at() ms/frame | at() ns/px | ptr ms/frame | ptr ns/px | ptr speedup vs at() |\n"
              << "|---|---|---|---|---|---|---|\n";
    for (auto& l : accessRows) std::cout << l << "\n";

    std::cout << "\n## Part 6: Full-frame vs streaming pipeline (grayscale + Sobel)\n\n"
              << "| Resolution | Size | Baseline intermediate | Baseline ms/frame | Baseline ns/px | "
                 "Streaming intermediate | Streaming ms/frame | Streaming ns/px | Streaming speedup |\n"
              << "|---|---|---|---|---|---|---|---|---|\n";
    for (auto& l : streamRows) std::cout << l << "\n";

    std::cout << "\n## Part 4: Baseline data movement per frame (minimum, each byte once)\n\n"
              << "| Resolution | Color in (3WH) | Gray (WH) | Output ((W-2)(H-2)) | "
                 "Baseline min read | Baseline min write | Naive gray loads (8/px) | Streaming rows (3W) |\n"
              << "|---|---|---|---|---|---|---|---|\n";
    for (auto& l : memRows) std::cout << l << "\n";

    std::cout << "\n## Correctness (all frames, every resolution; stride/ROI check also passed)\n\n"
              << "| Resolution | Comparison | Result |\n|---|---|---|\n";
    for (auto& l : correctRows) std::cout << l << "\n";
    return 0;
}

int main(int argc, char** argv) {
    const std::string mode = (argc > 1) ? argv[1] : "";
    if (mode == "traversal") return runTraversal(argc, argv);
    if (mode == "pipeline")  return runPipeline(argc, argv);
    if (mode == "compare")   return runCompare(argc, argv);

    std::cerr << "Usage:\n"
              << "  " << argv[0] << " traversal [N ...]\n"
              << "  " << argv[0] << " pipeline [video] [frames=5] [reps=5]\n"
              << "  " << argv[0] << " compare a.png b.png\n";
    return 1;
}
