// Lab 5: single-threaded compiler-optimization benchmark.
// Usage: ./lab5 [video] [frames=30] [repetitions=7]

#include <opencv2/opencv.hpp>
#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

using Clock = std::chrono::steady_clock;

static double median(std::vector<double> values) {
    std::sort(values.begin(), values.end());
    const size_t n = values.size();
    return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
}

// Kept out of line so its symbol is easy to locate in the requested assembly.
#if defined(__GNUC__) || defined(__clang__)
#define NOINLINE __attribute__((noinline))
#else
#define NOINLINE
#endif

#ifdef LAB2_BASELINE

// Same pixel loops as lab2.cpp, adapted only to write into caller-preallocated
// Mats so allocation is excluded from every build's timed region.
// Lab 2 uses floating-point BT.601 grayscale and Euclidean Sobel magnitude.
NOINLINE static void grayscale(const cv::Mat& color, cv::Mat& gray) {
    for (int y = 0; y < color.rows; ++y) {
        const uchar* in = color.ptr<uchar>(y);
        uchar* out = gray.ptr<uchar>(y);
        for (int x = 0; x < color.cols; ++x) {
            const double v = .114 * in[3 * x] + .587 * in[3 * x + 1]
                           + .299 * in[3 * x + 2];
            out[x] = static_cast<uchar>(std::lround(v));
        }
    }
}

NOINLINE static void sobel(const cv::Mat& gray, cv::Mat& out) {
    for (int y = 0; y < gray.rows - 2; ++y) {
        const uchar* rowAbove = gray.ptr<uchar>(y);
        const uchar* rowCenter = gray.ptr<uchar>(y + 1);
        const uchar* rowBelow = gray.ptr<uchar>(y + 2);
        uchar* outRow = out.ptr<uchar>(y);
        for (int x = 0; x < gray.cols - 2; ++x) {
            const int p00 = rowAbove[x], p01 = rowAbove[x + 1], p02 = rowAbove[x + 2];
            const int p10 = rowCenter[x], p12 = rowCenter[x + 2];
            const int p20 = rowBelow[x], p21 = rowBelow[x + 1], p22 = rowBelow[x + 2];
            const int gx = -p00 + p02 - 2 * p10 + 2 * p12 - p20 + p22;
            const int gy = -p00 - 2 * p01 - p02 + p20 + 2 * p21 + p22;
            const double magnitude = std::sqrt(static_cast<double>(gx) * gx + static_cast<double>(gy) * gy);
            outRow[x] = static_cast<uchar>(std::clamp(magnitude, 0.0, 255.0));
        }
    }
}

#else

// Current Labs 3/4 implementation: fixed-point BT.709, row pointers, and L1 Sobel.
// It deliberately contains no explicit SIMD or threads.
NOINLINE static void grayscale(const cv::Mat& color, cv::Mat& gray) {
    for (int y = 0; y < color.rows; ++y) {
        const uchar* in = color.ptr<uchar>(y);
        uchar* out = gray.ptr<uchar>(y);
        for (int x = 0; x < color.cols; ++x) {
            const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
                          + 218 * in[3 * x + 2] + 512;
            out[x] = static_cast<uchar>(sum >> 10);
        }
    }
}

NOINLINE static void sobel(const cv::Mat& gray, cv::Mat& out) {
    for (int y = 0; y < gray.rows - 2; ++y) {
        const uchar* a = gray.ptr<uchar>(y);
        const uchar* b = gray.ptr<uchar>(y + 1);
        const uchar* c = gray.ptr<uchar>(y + 2);
        uchar* dst = out.ptr<uchar>(y);
        for (int x = 0; x < gray.cols - 2; ++x) {
            const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
            const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
            const int magnitude = std::abs(gx) + std::abs(gy);
            dst[x] = static_cast<uchar>(std::min(magnitude, 255));
        }
    }
}
#endif

static std::vector<cv::Mat> loadFrames(const std::string& path, int count) {
    std::vector<cv::Mat> frames;
    if (!path.empty()) {
        cv::VideoCapture video(path);
        cv::Mat frame;
        while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
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
    return frames;
}

int main(int argc, char** argv) {
    const std::string video = argc > 1 ? argv[1] : "";
    const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
    const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
    std::vector<cv::Mat> color = loadFrames(video, frameCount);
    std::vector<cv::Mat> gray(color.size()), edges(color.size());
    for (size_t i = 0; i < color.size(); ++i) {
        gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
        edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
    }

    auto measure = [&](int stage) {
        std::vector<double> samples;
        for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
            const auto start = Clock::now();
            for (size_t i = 0; i < color.size(); ++i) {
                if (stage != 1) grayscale(color[i], gray[i]);
                if (stage != 0) sobel(gray[i], edges[i]);
            }
            if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
        }
        return median(samples);
    };

    const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
    std::cout << std::fixed << std::setprecision(3)
#ifdef LAB2_BASELINE
              << "Source: Lab 2 baseline\n";
#else
              << "Source: current optimized implementation\n";
#endif
    std::cout << "Frames: " << color.size() << " at " << color[0].cols << "x" << color[0].rows
              << "; median of " << reps << " repetitions (ms/frame)\n"
              << "Grayscale: " << grayMs << "\nSobel: " << sobelMs << "\nTotal: " << totalMs << "\n";
}
