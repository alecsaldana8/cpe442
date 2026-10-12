#include <opencv2/opencv.hpp>
#include <iostream>
#include <cmath>
#include <algorithm>
#include <chrono>

/*  
  converts an BRG color image (CV_8UC3, OpenCV's default channel order)
  to an 8-bit single-channel grayscale image using the standard
  luminosity formula:
     Y = 0.299*R + 0.587*G + 0.114*B
 
  pixel data is accessed directly viarow pointers, which is both faster 
  than Mat::at<>() in a hot loop and keeps the implementation explicit 
  for later performance comparisons.
*/

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

/* applies the Sobel operator to an 8-bit grayscale image (CV_8UC1) and
 returns an 8-bit gradient-magnitude image (CV_8UC1).

 the horizontal and vertical kernels are the standard 3x3 Sobel
 kernels:

   Gx = [-1  0  +1]      Gy = [-1 -2 -1]
        [-2  0  +2]           [ 0  0  0]
        [-1  0  +1]           [+1 +2 +1]

 for each pixel, both kernels are convolved with the surrounding 3x3
 neighborhood, producing horizontal and vertical gradients Gx and Gy.
 The gradient magnitude is G = sqrt(Gx^2 + Gy^2), clamped to [0, 255]
 since the result can exceed the 8-bit range.

 border pixels have no full 3x3 neighborhood available (a pixel in
 row 0, for example, has no row above it), so they are skipped
 entirely rather than handled with padding or clamped indices. This
 means the output image is exactly two rows and two columns smaller
 than the input: one row/column of border pixels is lost on each
 side (top+bottom, left+right) in each dimension.
*/
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

int main(int argc, char **argv)
{
  if (argc < 2)
  {
    std::cerr << "Usage: ./sobel_lab path_to_video \n";
    return 1;
  }

  const std::string video_path = argv[1];

  cv::VideoCapture cap(video_path);

  if(!cap.isOpened())
  {
    std::cerr << "couldnt open video path\n";
    return 1;	  
  }

  const std::string window_name = "sobel lab";
  cv::namedWindow(window_name, cv::WINDOW_NORMAL);
  
  const double fps = cap.get(cv::CAP_PROP_FPS);
  const int delayms = (fps > 0.0) ? static_cast<int>(1000.0 /fps) : 33;
  
  cv::Mat frame;

  using Clock = std::chrono::steady_clock;

  long long processedFrameCount = 0;
  double totalGrayscaleSeconds = 0.0;
  double totalSobelSeconds = 0.0;
  double totalComputeSeconds = 0.0; // grayscal + sobel

  const auto computeStart = Clock::now();

  while (true)
  {
    cap >> frame;

    if (frame.empty())
    {
      std::cout << "end of video reached\n";
      break;
    }

    // timed grayscale stage
    const auto grayStart = Clock::now();
    cv::Mat grayFrame = convertToGrayscale(frame);
    const auto grayEnd = Clock::now();
    const std::chrono::duration<double> grayDuration = grayEnd - grayStart;

    // timed sobel stage
    const auto sobelStart = Clock::now();
    cv::Mat sobelFrame = applySobel(grayFrame);
    const auto sobelEnd =  Clock::now();
    const std::chrono::duration<double> sobelDuration = sobelEnd - sobelStart;

    totalGrayscaleSeconds += grayDuration.count();
    totalSobelSeconds += sobelDuration.count();
    totalComputeSeconds += grayDuration.count() + sobelDuration.count();
    ++processedFrameCount;

    cv::imshow(window_name, sobelFrame);

    int key = cv::waitKey(delayms);
    if (key != -1)
    {
      std::cout << "key pressed, exiting\n";
      break;
    }

  }
  cap.release();
  cv::destroyAllWindows();

  // performance summary
  const auto computeEnd = Clock::now();
  const std::chrono::duration<double> computeDuration = computeEnd - computeStart;

  std::cout << "-----performance summary-----\n";
  std::cout << "frames processed: " << processedFrameCount << "\n";

  if (processedFrameCount > 0)
  {
    const double avgGrayscaleMs = (totalGrayscaleSeconds / processedFrameCount) * 1000.0;
    const double avgSobelMs = (totalSobelSeconds / processedFrameCount) * 1000.0;
    const double avgComputeMs = (totalComputeSeconds / processedFrameCount) * 1000.0;	

    // how many fps can this algo sustain without any overhead
    const double computeFps = (totalComputeSeconds > 0.0) 
	    ? processedFrameCount / totalComputeSeconds : 0.0;

    // wall-clock fps includes imshow()/waitKey overhead and frame decode time
    const double wallClockFps =  (computeDuration.count() > 0.0)
	    ? processedFrameCount / computeDuration.count() : 0.0;

    std::cout << "Avg grayscale time (ms)  : " << avgGrayscaleMs << "\n";
        std::cout << "Avg Sobel time (ms)      : " << avgSobelMs << "\n";
        std::cout << "Avg compute time (ms)    : " << avgComputeMs << "\n";
        std::cout << "Compute-only FPS         : " << computeFps << "\n";
        std::cout << "Wall-clock FPS (w/ display): " << wallClockFps << "\n";
  }

  return 0;  
}
