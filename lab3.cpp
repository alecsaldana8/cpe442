#include <opencv2/opencv.hpp>
#include <algorithm>
#include <chrono>
#include <cmath>
#include <iostream>

// Converts a BGR color image (CV_8UC3, OpenCV's default channel order)
// to an 8-bit single-channel grayscale image using the standard
// luminosity formula:
//
//     Y = 0.299*R + 0.587*G + 0.114*B
//
// This does NOT call cv::cvtColor. Pixel data is accessed directly via
// row pointers, which is both faster than Mat::at<>() in a hot loop and
// keeps the implementation explicit for later performance comparisons.
cv::Mat convertToGrayscale(const cv::Mat& colorFrame) {
    CV_Assert(colorFrame.type() == CV_8UC3);

    cv::Mat grayFrame(colorFrame.rows, colorFrame.cols, CV_8UC1);

    for (int y = 0; y < colorFrame.rows; ++y) {
        const uchar* inRow  = colorFrame.ptr<uchar>(y);
        uchar* outRow        = grayFrame.ptr<uchar>(y);

        for (int x = 0; x < colorFrame.cols; ++x) {
            // OpenCV stores color images as interleaved B, G, R bytes.
            const uchar B = inRow[3 * x + 0];
            const uchar G = inRow[3 * x + 1];
            const uchar R = inRow[3 * x + 2];

            const double gray = 0.299 * R + 0.587 * G + 0.114 * B;

            // Round to nearest and clamp is unnecessary here since the
            // weighted sum of three 8-bit values with weights summing
            // to 1.0 can never exceed 255 or go below 0.
            outRow[x] = static_cast<uchar>(std::lround(gray));
        }
    }

    return grayFrame;
}

// ============================================================================
// Lab 3, Part 1: Fixed-Point Grayscale
// ============================================================================
//
// convertToGrayscaleFloatBT709() is the accuracy REFERENCE: the exact
// BT.709 luma formula computed in floating point.
//
//     Y = 0.2126*R + 0.7152*G + 0.0722*B
//
// convertToGrayscaleFixedBT709() is the OPTIMIZED version: an integer-only
// approximation of the same formula, with no floating-point arithmetic
// anywhere in the per-pixel calculation.
//
// --- Fixed-point scheme ---
//
// We approximate each floating-point coefficient as an integer numerator
// over a power-of-two denominator (SCALE = 2^SHIFT = 1024):
//
//     0.2126 ~= 218/1024   (0.212890625,  abs error 0.00029)
//     0.7152 ~= 732/1024   (0.714843750,  abs error 0.00036)
//     0.0722 ~=  74/1024   (0.072265625,  abs error 0.00007)
//
// These three integers were obtained by rounding each coefficient*1024 to
// the nearest integer independently; by coincidence they sum to exactly
// 1024 (218+732+74 = 1024), so there is no overall scale bias to correct
// for. Using SHIFT=10 keeps the coefficients small (fits comfortably in
// 16 bits) while giving ~3 decimal digits of precision, which is more
// than enough given the output is only 8 bits wide.
//
// Per pixel we compute:
//
//     sum = R*218 + G*732 + B*74 + ROUND_OFFSET
//     Y   = sum >> SHIFT
//
// ROUND_OFFSET = SCALE/2 = 512 implements round-to-nearest (rather than
// truncation) using only integer addition: adding half the scale before
// an integer right-shift is the standard trick for rounding an integer
// division by a power of two.
//
// --- Division ---
//
// The division by 1024 is a right-shift (`>> 10`), not a `/` operator.
// Because SCALE is a power of two, the compiler would likely turn a
// `/1024` into a shift anyway at higher optimization levels -- but since
// this lab is compiled at -O0, that transformation would NOT happen
// automatically, and we'd pay for a real integer division instruction
// per pixel. Writing the shift explicitly guarantees the cheap operation
// happens regardless of optimization level, which is the point of this
// lab: WE are responsible for the optimization, not the compiler.
//
// --- Overflow check ---
//
// Worst case: R=G=B=255.
//   255 * (218+732+74) + 512 = 255*1024 + 512 = 261,632
// This fits easily within a 32-bit int (max ~2.1 billion), so `int` is
// sufficient for the accumulator with no risk of overflow.

constexpr int GRAY_FIXED_SHIFT = 10;
constexpr int GRAY_FIXED_SCALE = 1 << GRAY_FIXED_SHIFT; // 1024
constexpr int GRAY_FIXED_R = 218;
constexpr int GRAY_FIXED_G = 732;
constexpr int GRAY_FIXED_B = 74;
constexpr int GRAY_FIXED_ROUND = GRAY_FIXED_SCALE / 2; // 512, for rounding

// Reference implementation: exact BT.709 luma formula in floating point.
// Used only to measure the error introduced by the fixed-point version
// below -- it is NOT the fast path used for the live Sobel pipeline.
cv::Mat convertToGrayscaleFloatBT709(const cv::Mat& colorFrame) {
    CV_Assert(colorFrame.type() == CV_8UC3);

    cv::Mat grayFrame(colorFrame.rows, colorFrame.cols, CV_8UC1);

    for (int y = 0; y < colorFrame.rows; ++y) {
        const uchar* inRow = colorFrame.ptr<uchar>(y);
        uchar* outRow = grayFrame.ptr<uchar>(y);

        for (int x = 0; x < colorFrame.cols; ++x) {
            const uchar B = inRow[3 * x + 0];
            const uchar G = inRow[3 * x + 1];
            const uchar R = inRow[3 * x + 2];

            const double gray = 0.2126 * R + 0.7152 * G + 0.0722 * B;
            outRow[x] = static_cast<uchar>(std::lround(gray));
        }
    }

    return grayFrame;
}

// Optimized implementation: fixed-point integer approximation of the
// BT.709 luma formula. No floating-point arithmetic anywhere in the
// per-pixel loop.
cv::Mat convertToGrayscaleFixedBT709(const cv::Mat& colorFrame) {
    CV_Assert(colorFrame.type() == CV_8UC3);

    cv::Mat grayFrame(colorFrame.rows, colorFrame.cols, CV_8UC1);

    for (int y = 0; y < colorFrame.rows; ++y) {
        const uchar* inRow = colorFrame.ptr<uchar>(y);
        uchar* outRow = grayFrame.ptr<uchar>(y);

        for (int x = 0; x < colorFrame.cols; ++x) {
            const int B = inRow[3 * x + 0];
            const int G = inRow[3 * x + 1];
            const int R = inRow[3 * x + 2];

            const int sum = R * GRAY_FIXED_R
                          + G * GRAY_FIXED_G
                          + B * GRAY_FIXED_B
                          + GRAY_FIXED_ROUND;

            // Integer right-shift stands in for division by 1024.
            outRow[x] = static_cast<uchar>(sum >> GRAY_FIXED_SHIFT);
        }
    }

    return grayFrame;
}

// Compares two single-channel 8-bit images pixel-by-pixel and reports
// the maximum absolute error and the mean absolute error (MAE) between
// them. Used to quantify how much accuracy the fixed-point grayscale
// approximation gives up relative to the floating-point reference.
struct ErrorStats {
    int maxAbsError = 0;
    double sumAbsError = 0.0;
    long long pixelCount = 0;

    double meanAbsError() const {
        return (pixelCount > 0) ? sumAbsError / pixelCount : 0.0;
    }
};

void accumulateGrayscaleError(const cv::Mat& reference,
                               const cv::Mat& candidate,
                               ErrorStats& stats) {
    CV_Assert(reference.size() == candidate.size());
    CV_Assert(reference.type() == CV_8UC1 && candidate.type() == CV_8UC1);

    for (int y = 0; y < reference.rows; ++y) {
        const uchar* refRow = reference.ptr<uchar>(y);
        const uchar* candRow = candidate.ptr<uchar>(y);

        for (int x = 0; x < reference.cols; ++x) {
            const int diff = std::abs(static_cast<int>(refRow[x]) -
                                       static_cast<int>(candRow[x]));
            stats.maxAbsError = std::max(stats.maxAbsError, diff);
            stats.sumAbsError += diff;
            ++stats.pixelCount;
        }
    }
}
// ============================================================================


// returns an 8-bit gradient-magnitude image (CV_8UC1). Does NOT call
// cv::Sobel, cvSobel, or any other built-in edge-detection routine.
//
// The horizontal and vertical kernels are the standard 3x3 Sobel
// kernels:
//
//   Gx = [-1  0  +1]      Gy = [-1 -2 -1]
//        [-2  0  +2]           [ 0  0  0]
//        [-1  0  +1]           [+1 +2 +1]
//
// For each pixel, both kernels are convolved with the surrounding 3x3
// neighborhood, producing horizontal and vertical gradients Gx and Gy.
// The gradient magnitude is G = sqrt(Gx^2 + Gy^2), clamped to [0, 255]
// since the result can exceed the 8-bit range.
//
// Border pixels have no full 3x3 neighborhood available (a pixel in
// row 0, for example, has no row above it), so they are skipped
// entirely rather than handled with padding or clamped indices. This
// means the output image is exactly two rows and two columns smaller
// than the input: one row/column of border pixels is lost on each
// side (top+bottom, left+right) in each dimension.
cv::Mat applySobel(const cv::Mat& grayFrame) {
    CV_Assert(grayFrame.type() == CV_8UC1);
    CV_Assert(grayFrame.rows >= 3 && grayFrame.cols >= 3);

    const int outRows = grayFrame.rows - 2;
    const int outCols = grayFrame.cols - 2;

    cv::Mat sobelFrame(outRows, outCols, CV_8UC1);

    for (int y = 0; y < outRows; ++y) {
        // Row y of the output corresponds to row (y+1) of the input,
        // since row 0 of the input has no row above it to convolve with.
        const uchar* rowAbove  = grayFrame.ptr<uchar>(y);
        const uchar* rowCenter = grayFrame.ptr<uchar>(y + 1);
        const uchar* rowBelow  = grayFrame.ptr<uchar>(y + 2);
        uchar* outRow           = sobelFrame.ptr<uchar>(y);

        for (int x = 0; x < outCols; ++x) {
            // Column x of the output corresponds to column (x+1) of
            // the input, for the same reason as above.
            const int p00 = rowAbove[x];      // top-left
            const int p01 = rowAbove[x + 1];  // top-center
            const int p02 = rowAbove[x + 2];  // top-right
            const int p10 = rowCenter[x];      // mid-left
            const int p12 = rowCenter[x + 2];  // mid-right
            const int p20 = rowBelow[x];      // bottom-left
            const int p21 = rowBelow[x + 1];  // bottom-center
            const int p22 = rowBelow[x + 2];  // bottom-right

            // Gx: horizontal gradient kernel.
            const int gx = (-p00 + p02)
                         + (-2 * p10 + 2 * p12)
                         + (-p20 + p22);

            // Gy: vertical gradient kernel.
            const int gy = (-p00 - 2 * p01 - p02)
                         + (p20 + 2 * p21 + p22);

            const double magnitude = std::sqrt(
                static_cast<double>(gx) * gx + static_cast<double>(gy) * gy);

            // Clamp to the 8-bit range, since the magnitude can exceed 255.
            outRow[x] = static_cast<uchar>(
                std::clamp(magnitude, 0.0, 255.0));
        }
    }

    return sobelFrame;
}

// ============================================================================
// Lab 3, Part 2: Approximate Gradient Magnitude
// ============================================================================
//
// applySobel() above computes the exact Euclidean magnitude:
//
//     G = sqrt(Gx^2 + Gy^2)
//
// applySobelApprox() below replaces that with the L1 (Manhattan / taxicab)
// norm:
//
//     G ~= |Gx| + |Gy|
//
// --- Why this is cheaper ---
//
// The exact version costs, per pixel: two integer->double conversions,
// two multiplies, one add, and one call to std::sqrt(). sqrt() is by far
// the most expensive of these: it is not a single-cycle arithmetic
// instruction like add or multiply, and at -O0 the compiler will not
// hoist, approximate, or vectorize it away.
//
// The approximation costs, per pixel: two std::abs() calls and one add,
// all in integer arithmetic. No floating point is involved at any point,
// so we also avoid the int->double conversions entirely.
//
// --- How much error does this introduce? ---
//
// The L1 norm always OVERESTIMATES the Euclidean (L2) norm, never
// underestimates it:
//
//     sqrt(Gx^2 + Gy^2)  <=  |Gx| + |Gy|  <=  sqrt(2) * sqrt(Gx^2 + Gy^2)
//
// The two agree exactly when either gradient is zero (a purely
// horizontal or purely vertical edge). The worst case is |Gx| == |Gy|
// (a perfect 45-degree diagonal edge), where the approximation is too
// large by a factor of sqrt(2) ~= 1.414, i.e. about 41% too high.
//
// Visually this means diagonal edges appear brighter than they should
// relative to axis-aligned ones, and because the result is clamped to
// 255, more pixels saturate to pure white. Edges therefore look
// somewhat thicker and brighter overall. For an edge DETECTOR -- where
// we mostly care whether a gradient is large, not its exact value --
// this distortion is usually acceptable.
cv::Mat applySobelApprox(const cv::Mat& grayFrame) {
    CV_Assert(grayFrame.type() == CV_8UC1);
    CV_Assert(grayFrame.rows >= 3 && grayFrame.cols >= 3);

    const int outRows = grayFrame.rows - 2;
    const int outCols = grayFrame.cols - 2;

    cv::Mat sobelFrame(outRows, outCols, CV_8UC1);

    for (int y = 0; y < outRows; ++y) {
        const uchar* rowAbove  = grayFrame.ptr<uchar>(y);
        const uchar* rowCenter = grayFrame.ptr<uchar>(y + 1);
        const uchar* rowBelow  = grayFrame.ptr<uchar>(y + 2);
        uchar* outRow           = sobelFrame.ptr<uchar>(y);

        for (int x = 0; x < outCols; ++x) {
            const int p00 = rowAbove[x];
            const int p01 = rowAbove[x + 1];
            const int p02 = rowAbove[x + 2];
            const int p10 = rowCenter[x];
            const int p12 = rowCenter[x + 2];
            const int p20 = rowBelow[x];
            const int p21 = rowBelow[x + 1];
            const int p22 = rowBelow[x + 2];

            const int gx = (-p00 + p02)
                         + (-2 * p10 + 2 * p12)
                         + (-p20 + p22);

            const int gy = (-p00 - 2 * p01 - p02)
                         + (p20 + 2 * p21 + p22);

            // L1 norm: integer-only, no sqrt, no floating point.
            const int magnitude = std::abs(gx) + std::abs(gy);

            // Still must clamp: |Gx| and |Gy| each range up to 1020, so
            // their sum can reach 2040, well beyond the 8-bit range.
            outRow[x] = static_cast<uchar>(std::min(magnitude, 255));
        }
    }

    return sobelFrame;
}
// ============================================================================

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <path-to-video>\n";
        return 1;
    }

    const std::string videoPath = argv[1];

    // Open the video file.
    cv::VideoCapture cap(videoPath);
    if (!cap.isOpened()) {
        std::cerr << "Error: could not open video file: " << videoPath << "\n";
        return 1;
    }

    // Some basic info about the source, useful to confirm we opened
    // the right file (e.g. that it really is 4K60).
    const double fps = cap.get(cv::CAP_PROP_FPS);
    const int width  = static_cast<int>(cap.get(cv::CAP_PROP_FRAME_WIDTH));
    const int height = static_cast<int>(cap.get(cv::CAP_PROP_FRAME_HEIGHT));
    const int frameCount = static_cast<int>(cap.get(cv::CAP_PROP_FRAME_COUNT));

    std::cout << "Opened video: " << videoPath << "\n"
              << "  Resolution : " << width << "x" << height << "\n"
              << "  FPS        : " << fps << "\n"
              << "  Frame count: " << frameCount << "\n";

    const std::string windowName = "Sobel Lab - Part 4 (Sobel edge detection)";
    cv::namedWindow(windowName, cv::WINDOW_NORMAL);

    // Approximate the source frame rate when choosing the wait delay
    // between frames so playback runs at roughly the correct speed.
    // Fall back to a reasonable default if FPS metadata is missing.
    const int delayMs = (fps > 0.0) ? static_cast<int>(1000.0 / fps) : 33;

    cv::Mat frame;

    // --- Performance measurement setup -------------------------------
    // We time the grayscale and Sobel stages separately (in addition to
    // their combined total) using a steady, monotonic clock. Wall clock
    // (system_clock) can jump backward/forward with NTP adjustments;
    // steady_clock is guaranteed monotonic, which is what you want for
    // measuring elapsed durations.
    using Clock = std::chrono::steady_clock;

    long long processedFrameCount = 0;
    double totalGrayscaleSeconds = 0.0;      // fixed-point grayscale (fast path)
    double totalGrayscaleRefSeconds = 0.0;   // floating-point grayscale (reference)
    double totalSobelSeconds = 0.0;          // exact Euclidean magnitude
    double totalSobelApproxSeconds = 0.0;    // |Gx| + |Gy| approximation
    double totalComputeSeconds = 0.0;  // OPTIMIZED: fixed gray + approx sobel
    double totalBaselineSeconds = 0.0; // BASELINE:  float gray + exact sobel

    ErrorStats grayscaleError; // accuracy of fixed-point vs. float reference
    ErrorStats sobelError;     // accuracy of L1 approximation vs. exact Euclidean

    // Save one representative frame from each Sobel variant to disk so
    // the writeup can include side-by-side images. Frame 0 is often a
    // fade-in/blank frame in this video, so grab a later one.
    const long long sampleFrameIndex = 100;
    bool sampleSaved = false;

    const auto runStart = Clock::now();
    // -------------------------------------------------------------------

    while (true) {
        cap >> frame; // Read the next frame.

        // Video has ended (empty frame returned).
        if (frame.empty()) {
            std::cout << "End of video reached.\n";
            break;
        }

        // --- Timed grayscale stage: fixed-point (fast path, drives Sobel) ---
        const auto grayStart = Clock::now();
        cv::Mat grayFrame = convertToGrayscaleFixedBT709(frame);
        const auto grayEnd = Clock::now();

        // --- Timed grayscale stage: floating-point reference (for error/perf comparison only) ---
        const auto grayRefStart = Clock::now();
        cv::Mat grayFrameRef = convertToGrayscaleFloatBT709(frame);
        const auto grayRefEnd = Clock::now();

        accumulateGrayscaleError(grayFrameRef, grayFrame, grayscaleError);

        // --- Timed Sobel stage: exact Euclidean magnitude (reference) ---
        const auto sobelStart = Clock::now();
        cv::Mat sobelFrame = applySobel(grayFrame);
        const auto sobelEnd = Clock::now();

        // --- Timed Sobel stage: |Gx| + |Gy| approximation (fast path) ---
        const auto sobelApproxStart = Clock::now();
        cv::Mat sobelApproxFrame = applySobelApprox(grayFrame);
        const auto sobelApproxEnd = Clock::now();

        accumulateGrayscaleError(sobelFrame, sobelApproxFrame, sobelError);

        const std::chrono::duration<double> grayDuration = grayEnd - grayStart;
        const std::chrono::duration<double> grayRefDuration = grayRefEnd - grayRefStart;
        const std::chrono::duration<double> sobelDuration = sobelEnd - sobelStart;
        const std::chrono::duration<double> sobelApproxDuration =
            sobelApproxEnd - sobelApproxStart;

        totalGrayscaleSeconds += grayDuration.count();
        totalGrayscaleRefSeconds += grayRefDuration.count();
        totalSobelSeconds += sobelDuration.count();
        totalSobelApproxSeconds += sobelApproxDuration.count();
        totalComputeSeconds += grayDuration.count() + sobelApproxDuration.count();
        totalBaselineSeconds += grayRefDuration.count() + sobelDuration.count();
        ++processedFrameCount;

        // Save a matched pair of output frames for the writeup, plus an
        // amplified difference image that makes the disagreement visible.
        if (!sampleSaved && processedFrameCount == sampleFrameIndex) {
            cv::Mat diff;
            cv::absdiff(sobelFrame, sobelApproxFrame, diff);

            cv::imwrite("sobel_exact.png", sobelFrame);
            cv::imwrite("sobel_approx.png", sobelApproxFrame);
            cv::imwrite("sobel_diff.png", diff);
            // Scaled 4x so the (mostly small) differences are actually
            // visible in the writeup rather than looking uniformly black.
            cv::imwrite("sobel_diff_x4.png", diff * 4);

            std::cout << "Saved sample images at frame " << sampleFrameIndex
                      << ": sobel_exact.png, sobel_approx.png, "
                         "sobel_diff.png, sobel_diff_x4.png\n";
            sampleSaved = true;
        }

        cv::imshow(windowName, sobelApproxFrame);

        // Wait for a key press for up to delayMs milliseconds.
        // waitKey also processes the GUI event loop, which is required
        // for imshow to actually paint the window.
        int key = cv::waitKey(delayMs);
        if (key != -1) {
            std::cout << "Key pressed, exiting playback.\n";
            break;
        }
    }

    cap.release();
    cv::destroyAllWindows();

    // --- Performance summary -------------------------------------------
    const auto runEnd = Clock::now();
    const std::chrono::duration<double> wallClockSeconds = runEnd - runStart;

    std::cout << "\n===== Performance Summary =====\n";
    std::cout << "Frames processed        : " << processedFrameCount << "\n";

    if (processedFrameCount > 0) {
        const double avgGrayMs =
            (totalGrayscaleSeconds / processedFrameCount) * 1000.0;
        const double avgGrayRefMs =
            (totalGrayscaleRefSeconds / processedFrameCount) * 1000.0;
        const double avgSobelMs =
            (totalSobelSeconds / processedFrameCount) * 1000.0;
        const double avgComputeMs =
            (totalComputeSeconds / processedFrameCount) * 1000.0;

        // FPS based purely on compute time (grayscale + Sobel), which is
        // the metric the assignment asks for as the baseline: how many
        // frames per second this algorithm could sustain if it were
        // running back-to-back with no display/I/O overhead.
        const double computeFps =
            (totalComputeSeconds > 0.0)
                ? processedFrameCount / totalComputeSeconds
                : 0.0;

        // Wall-clock FPS additionally includes imshow/waitKey overhead
        // and frame decode time, useful context but NOT the number the
        // assignment wants as the algorithm's baseline FPS.
        const double wallClockFps =
            (wallClockSeconds.count() > 0.0)
                ? processedFrameCount / wallClockSeconds.count()
                : 0.0;

        const double graySpeedup =
            (totalGrayscaleSeconds > 0.0)
                ? totalGrayscaleRefSeconds / totalGrayscaleSeconds
                : 0.0;

        std::cout << "--- Sobel pipeline timing ---\n";
        std::cout << "Avg grayscale time (ms)   : " << avgGrayMs << "\n";
        std::cout << "Avg Sobel time (ms)       : " << avgSobelMs << "\n";
        std::cout << "Avg compute time (ms)     : " << avgComputeMs << "\n";
        std::cout << "Compute-only FPS          : " << computeFps << "\n";
        std::cout << "Wall-clock FPS (w/ display): " << wallClockFps << "\n";

        std::cout << "\n--- Lab 3 Part 1: Fixed-point grayscale ---\n";
        std::cout << "Avg float grayscale (ms) : " << avgGrayRefMs << "\n";
        std::cout << "Avg fixed grayscale (ms) : " << avgGrayMs << "\n";
        std::cout << "Grayscale speedup (float/fixed): " << graySpeedup << "x\n";
        std::cout << "Max abs pixel error       : " << grayscaleError.maxAbsError << "\n";
        std::cout << "Mean abs pixel error      : " << grayscaleError.meanAbsError() << "\n";
        std::cout << "Pixels compared           : " << grayscaleError.pixelCount << "\n";

        const double avgSobelApproxMs =
            (totalSobelApproxSeconds / processedFrameCount) * 1000.0;
        const double sobelSpeedup =
            (totalSobelApproxSeconds > 0.0)
                ? totalSobelSeconds / totalSobelApproxSeconds
                : 0.0;

        std::cout << "\n--- Lab 3 Part 2: Approximate gradient magnitude ---\n";
        std::cout << "Avg exact sqrt Sobel (ms) : " << avgSobelMs << "\n";
        std::cout << "Avg |Gx|+|Gy| Sobel (ms)  : " << avgSobelApproxMs << "\n";
        std::cout << "Sobel speedup (exact/approx): " << sobelSpeedup << "x\n";
        std::cout << "Max abs pixel error       : " << sobelError.maxAbsError << "\n";
        std::cout << "Mean abs pixel error      : " << sobelError.meanAbsError() << "\n";
        std::cout << "Pixels compared           : " << sobelError.pixelCount << "\n";

        // ---- Deliverable table (Part 3) ----
        const double avgBaselineMs =
            (totalBaselineSeconds / processedFrameCount) * 1000.0;
        const double baselineFps =
            (totalBaselineSeconds > 0.0)
                ? processedFrameCount / totalBaselineSeconds
                : 0.0;
        const double overallSpeedup =
            (totalComputeSeconds > 0.0)
                ? totalBaselineSeconds / totalComputeSeconds
                : 0.0;

        std::cout << "\n=== DELIVERABLE TABLE (per frame, ms) ===\n";
        std::cout << "Stage                        |   ms   |  FPS\n";
        std::cout << "-----------------------------+--------+-------\n";
        std::cout << "Float grayscale (baseline)   | " << avgGrayRefMs << "\n";
        std::cout << "Fixed-point grayscale (opt)  | " << avgGrayMs << "\n";
        std::cout << "Exact sqrt Sobel (baseline)  | " << avgSobelMs << "\n";
        std::cout << "Approx |Gx|+|Gy| Sobel (opt) | " << avgSobelApproxMs << "\n";
        std::cout << "-----------------------------+--------+-------\n";
        std::cout << "BASELINE combined            | " << avgBaselineMs
                  << " | " << baselineFps << "\n";
        std::cout << "OPTIMIZED combined           | " << avgComputeMs
                  << " | " << computeFps << "\n";
        std::cout << "Overall speedup              : " << overallSpeedup << "x\n";
    }
    std::cout << "================================\n";
    // ---------------------------------------------------------------------

    return 0;
}
