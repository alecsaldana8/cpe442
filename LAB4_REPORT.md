# Lab 4: Memory Hierarchy and Data Locality

## Setup and Measurement Method

**Hardware:** Apple M2 (8-core). L1 data cache: 128 KiB per performance core (64 KiB per efficiency core). L2: 16 MiB shared across the performance cluster. Cache line: 128 B. Memory page: 16 KiB.

**Build:** `g++ -std=c++17 -O0 -Wall -Wextra` (Apple clang 14.0.3) against OpenCV 5.0 (`make lab4`). No optimization flags, SIMD intrinsics, threads or GPU.

**Arithmetic (identical in every implementation):** my selected Lab 3 arithmetic is used throughout. Neither equation changes between any of the implementations being compared.
- Grayscale: fixed-point BT.709, `Y = (218R + 732G + 74B + 512) >> 10`
- Sobel: standard 3×3 Gx/Gy kernels, magnitude `min(|Gx| + |Gy|, 255)`
- Border policy: border pixels are skipped, so the output is (W−2)×(H−2)

**Input:** 5 consecutive frames starting at frame 600 of `bbb_sunflower_2160p_60fps_normal.mp4` (3840×2160). Frames were resized to each test resolution with `cv::resize` before timing. Every implementation processes the same 5 frames at each resolution.

**Measurement region:** only the grayscale and Sobel computation on frames already decoded into memory. Excluded from timing:
- Video decode and resizing
- Buffer allocation: every output, grayscale-frame and row buffer is allocated before the timed loop and reused
- Correctness comparison, PNG output and display

**Timing procedure:**
- Timer: `std::chrono::steady_clock`
- Each implementation gets one warm-up pass, then 5 timed repetitions over all 5 frames
- Within each repetition the implementations take turns, so thermal or background drift affects them equally
- The **median** repetition is reported
- Time per pixel = time per frame ÷ (W−2)(H−2) output pixels

**Source organization (`lab4.cpp`):**

| Deliverable | Function(s) |
|---|---|
| Row- vs column-major traversal | `traverseRowMajor`, `traverseColMajor`, `runTraversal` (`./lab4 traversal`) |
| Baseline full-frame pipeline, `.at()` accessor | `grayFull` + `sobelFullAt` |
| Baseline full-frame pipeline, `.ptr()` accessor | `grayFull` + `sobelFullPtr` (`pipelineFull`) |
| Three-row streaming pipeline | `pipelineStreaming` |
| Output comparison | `compareImages` (also `./lab4 compare a.png b.png`) |
| Benchmark driver | `runPipeline` (`./lab4 pipeline <video> [frames] [reps]`) |

The baseline and streaming pipelines call the same per-row kernels (`grayRowFixed`, `sobelRowApprox`). Their arithmetic is therefore literally the same code; the only difference is where the intermediate grayscale data is stored. The baseline output for each resolution is saved as `lab4_baseline_WxH.png` for later comparisons.

---

## Part 2: Memory Traversal Experiment

**Method:** each array is one contiguous `int32_t` block in row-major layout, so element [r][c] is at offset `r*N + c`. Both traversals:
- compute the same index expression
- perform the same operation: add the element to a 64-bit checksum
- differ only in loop nesting

Every element is initialized before timing. Each trial visits about 67 million elements; small arrays are traversed repeatedly to reach that count. The median of 5 trials is reported.

| Dimensions | Elements | Array size | Where it fits | Col-major stride | Row-major (ms/pass) | Col-major (ms/pass) | Row ns/elem | Col ns/elem | Row-major speedup | Same checksum? |
|---|---|---|---|---|---|---|---|---|---|---|
| 16×16 (small) | 256 | 1 KiB | L1 | 64 B | 0.0003 | 0.0003 | 1.040 | 1.035 | 1.00× | Yes |
| 128×128 (medium) | 16,384 | 64 KiB | L1 | 512 B | 0.0164 | 0.0164 | 0.999 | 1.004 | 1.00× | Yes |
| 1024×1024 (large) | 1,048,576 | 4 MiB | L2 only | 4 KiB | 1.015 | 1.333 | 0.968 | 1.272 | 1.31× | Yes |
| 4096×4096 (large) | 16,777,216 | 64 MiB | DRAM | 16 KiB | 15.90 | 115.58 | 0.947 | 6.889 | 7.27× | Yes |
| 8192×8192 (large) | 67,108,864 | 256 MiB | DRAM | 32 KiB | 63.49 | 476.86 | 0.946 | 7.106 | 7.51× | Yes |

Row-major speedup = column-major time ÷ row-major time. Checksums matched exactly at every size (e.g. 18014405614632960 at 4096×4096), confirming both traversals did identical work.

### Explanation

**Physical layout:** C/C++ and OpenCV store 2D data one row after another. Moving one column to the right moves 4 bytes in memory. Moving one row down moves an entire row, N × 4 bytes.

**Row-major traversal (consecutive accesses 4 bytes apart):**
- A 128 B cache line holds 32 `int32_t` values.
- One line fetch serves 32 consecutive accesses, so only 1 in 32 accesses misses.
- The hardware prefetcher recognizes the sequential stream and fetches lines before they are needed.
- As a result, row-major time stays about 0.95–1.0 ns per element from 1 KiB all the way to 256 MiB.

**Column-major traversal (consecutive accesses N × 4 bytes apart):**
- Once the stride is 128 B or more (N ≥ 32), every access lands on a different cache line, and only 4 of that line's 128 bytes are used before jumping away.
- The line is only useful again when the traversal reaches the next column, N accesses later.
- If the N lines touched by one column don't fit in L1, they are evicted before that reuse, and nearly every access misses L1.
- At 4096 and 8192, the 16–32 KiB stride also means every access touches a different 16 KiB page. That adds TLB misses on top of cache misses.
- The result is about 7 ns per element, 7–7.5× slower than row-major.

**Spatial locality** is what row-major exploits and column-major wastes: row-major uses every byte of each fetched line immediately.

---

## Part 3: Pixel-Access Experiment

**Method:** `sobelFullAt` and `sobelFullPtr` are the two versions compared. Both:
- traverse in row-major order
- use the same arithmetic and border policy
- read the same precomputed grayscale frames and write into the same preallocated output size

The only difference is the access mechanism:
- `sobelFullAt` calls `gray.at<uchar>(y, x)` for each of the 8 neighbor reads and `out.at<uchar>(y, x)` for the write, so 9 calls per pixel.
- `sobelFullPtr` calls `ptr<uchar>()` once per row and indexes the row pointers.

The grayscale stage is excluded from this timing so that only the Sobel stage is measured.

### Performance

| Resolution | Method | Execution time (ms/frame) | Time per pixel (ns) | Relative performance |
|---|---|---|---|---|
| 320×180 | `cv::Mat::at()` | 1.380 | 24.37 | 1.00× |
| 320×180 | Row pointers | 0.507 | 8.95 | 2.72× |
| 1280×720 | `cv::Mat::at()` | 21.283 | 23.19 | 1.00× |
| 1280×720 | Row pointers | 7.946 | 8.66 | 2.68× |
| 1920×1080 | `cv::Mat::at()` | 47.420 | 22.94 | 1.00× |
| 1920×1080 | Row pointers | 17.698 | 8.56 | 2.68× |
| 3840×2160 | `cv::Mat::at()` | 190.367 | 22.99 | 1.00× |
| 3840×2160 | Row pointers | 70.288 | 8.49 | 2.71× |
| 7680×4320 | `cv::Mat::at()` | 759.089 | 22.90 | 1.00× |
| 7680×4320 | Row pointers | 274.033 | 8.27 | 2.77× |

### Correctness (all 5 frames, every resolution)

| Resolution | Output pixels compared | Differing pixels | Max abs difference | Bit-for-bit identical? |
|---|---|---|---|---|
| 320×180 | 283,020 | 0 | 0 | Yes |
| 1280×720 | 4,588,020 | 0 | 0 | Yes |
| 1920×1080 | 10,338,020 | 0 | 0 | Yes |
| 3840×2160 | 41,412,020 | 0 | 0 | Yes |
| 7680×4320 | 165,768,020 | 0 | 0 | Yes |

### Analysis

**Did row-pointer access improve performance? By how much?**
Yes. Row pointers were 2.68–2.77× faster at every resolution: about 23 ns/px with `.at()` versus about 8.5 ns/px with pointers. They removed roughly 63% of the Sobel stage's execution time.

**Why might calling `.at()` for each pixel require more work than indexing through a row pointer?**
At `-O0`, `.at<uchar>(y, x)` is not inlined. Each call:
- pushes arguments and sets up a stack frame
- loads the Mat's `data` pointer and `step[0]` from the Mat object
- computes `data + y*step[0] + x` (a multiply and two adds)
- returns a reference, which is then dereferenced

The Sobel loop does this 9 times per pixel. The row-pointer version calls `ptr()` only 4 times per row (three input rows and one output row). After that, each access is a single add and load: `rowAbove[x + 1]`.

**Does this experiment primarily measure cache locality, pixel-access overhead, or both?**
Primarily pixel-access overhead. Both versions touch the same bytes in the same order, so the cache sees an identical access stream. The evidence:
- The speedup is constant (about 2.7×) from 320×180, where the grayscale frame is 56 KiB and fits in L1, to 7680×4320, where it is 32 MiB and fits in no cache.
- A cache effect would change as the working set crossed cache boundaries; a fixed per-access cost does not.
- Time per pixel is also nearly constant across resolutions for each method.

**Why is it important that both versions use the same traversal order?**
It keeps memory behavior the same so that access overhead is the only variable. If one version traversed column-major, it would also pay the locality penalty measured in Part 2. The two effects would then be mixed together, and the speedup couldn't be attributed to either one.

**Would the difference remain equally large at `-O3`? (prediction)**
No. I expect the gap to shrink to nearly 1× at `-O3`:
- `.at()` is a small inline template. The compiler would inline it, remove the call overhead, and hoist the loop-invariant row address `data + y*step` out of the inner loop.
- That produces essentially the same code as the manual row-pointer version.
- The compiler may also vectorize both loops the same way.

**Purpose of obtaining each row through `ptr()` rather than assuming one tightly packed array:**
A `cv::Mat` row is `step` bytes long, which may be larger than `cols × elemSize`:
- Rows can be padded for alignment.
- The Mat can be an ROI or submatrix of a larger image, in which case consecutive rows are separated by the parent's full row width.
- `ptr(y)` returns `data + y*step`, which is always correct. Indexing `data[y*cols + x]` is only correct when `isContinuous()` is true.

My benchmark verifies this. It runs the full-frame and streaming pipelines on a non-continuous color ROI (`CV_Assert(!roi.isContinuous())`) and asserts that their outputs match each other and the `.at()` version bit-for-bit.

**For a multichannel image, how does the pixel type differ from a single-channel grayscale image?**
- **Grayscale (`CV_8UC1`):** each pixel is one `uchar`, accessed as `at<uchar>(y, x)` or `ptr<uchar>(y)[x]`.
- **BGR color (`CV_8UC3`):** each pixel is three interleaved bytes (B, G, R), so the pixel type is `cv::Vec3b`, accessed as `at<cv::Vec3b>(y, x)`.
  - Through a byte pointer, pixel x's channels are at `row[3*x + 0]`, `row[3*x + 1]` and `row[3*x + 2]`, as in `grayRowFixed`.
  - A color row is therefore 3 × width bytes. Using the wrong template type with `at<>()` would read the wrong addresses.

---

## Part 4: Baseline Pipeline Data Movement

Baseline pipeline: `color (CV_8UC3) → grayscale frame (CV_8UC1) → Sobel output (CV_8UC1)`

| Buffer | Read or written | Size (bytes) | Temporary? |
|---|---|---|---|
| Color input | Read once by grayscale | 3WH | No (input) |
| Grayscale frame | Written by grayscale, then read by Sobel | WH | **Yes**: only exists to pass data from grayscale to Sobel |
| Sobel output | Written once by Sobel | (W−2)(H−2) | No (result) |

**Reuse in Sobel:**
- Each output pixel reads the 8 neighbors of its 3×3 window; the center pixel has weight 0 in both kernels.
- An interior grayscale pixel is therefore read by up to 8 different output pixels: the ones to its left and right in its own row, and three each in the rows above and below.
- Horizontally adjacent outputs share 4 of their 8 inputs (two in the row above, two in the row below), and their 3×3 windows overlap in 6 pixels.
- A grayscale row is used by three consecutive output rows.

**Is reused data accessed soon after its previous use?**
- Horizontal reuse happens within a few accesses and always hits in cache.
- Vertical reuse happens one full row later, about W bytes of grayscale reads per row in between. At 4K that is about 3.8 KB per row, well within L1.
- However, the baseline writes the entire grayscale frame (WH bytes) before Sobel reads any of it. The time between writing a grayscale pixel and first reading it is a whole frame.

**Growth with resolution:** the grayscale frame is W×H bytes and grows with the pixel count. It no longer fits in the 16 MiB L2 at 8K.

| Resolution | Color in (3WH) | Grayscale frame (WH) | Output ((W−2)(H−2)) | Fits in |
|---|---|---|---|---|
| 320×180 | 0.17 MB | 56 KiB (0.06 MB) | 0.06 MB | L1 |
| 1280×720 | 2.76 MB | 900 KiB (0.92 MB) | 0.92 MB | L2 |
| 1920×1080 | 6.22 MB | 2.0 MiB (2.07 MB) | 2.07 MB | L2 |
| 3840×2160 | 24.88 MB | 7.9 MiB (8.29 MB) | 8.28 MB | L2 |
| 7680×4320 | 99.53 MB | 31.6 MiB (33.18 MB) | 33.15 MB | Neither (DRAM) |

### Minimum bytes moved per frame (baseline)

**Assumptions:**
- Every byte of each Mat is read or written exactly once, meaning perfect reuse of overlapping Sobel neighborhoods through cache.
- Cache-line granularity and write-allocate traffic are ignored.
- Local variables and loop counters are not counted.
- The output is written once.

| | Formula | 1920×1080 | 3840×2160 | 7680×4320 |
|---|---|---|---|---|
| Reads | 3WH (color) + WH (grayscale) = **4WH** | 8.29 MB | 33.18 MB | 132.71 MB |
| Writes | WH (grayscale) + (W−2)(H−2) (output) ≈ **2WH** | 4.14 MB | 16.58 MB | 66.33 MB |
| **Total** | **≈ 6WH** | 12.4 MB | 49.8 MB | 199.0 MB |

For comparison, Sobel performs 8 grayscale loads per output pixel, about 8WH load instructions (265 MB at 8K). Only one eighth of that is unique data; the rest must be served by cache reuse.

Of the roughly 6WH bytes, 2WH (writing and re-reading the grayscale frame) is avoidable traffic. It exists only because the two stages communicate through a full frame.

---

## Part 5: Streaming Implementation

`pipelineStreaming` keeps a single preallocated `3 × W` `CV_8UC1` Mat (`rowBuf`), reused across frames, plus three pointers `above`, `center` and `below` into its rows.

1. **Prime:** convert color rows 0 and 1 into `above` and `center`.
2. **For each output row y = 0 … H−3:**
   - Convert color row y+2 into `below`.
   - Compute Sobel output row y from `above`, `center` and `below`, which hold grayscale rows y, y+1 and y+2.
   - **Rotate:** `oldest = above; above = center; center = below; below = oldest;`
3. The buffer that held grayscale row y has had its last use, so it becomes the destination for row y+3.

Only pointers move; no row data is ever copied.

**Edge cases:**
- **First and last rows:** handled by priming two rows and stopping at output row H−3, the same "skip the border" policy as the baseline.
- **First and last pixel in each row:** handled by the same `sobelRowApprox` kernel as the baseline, which reads columns x…x+2 for output x.
- **Row stride:** every color row is obtained with `color.ptr<uchar>(y)`. This was verified on a non-continuous ROI.
- **Overwriting a row before its final use:** `below` is overwritten only after rotation, at which point it holds a row no future output needs.

**Correctness:** streaming output matches the baseline bit-for-bit on all 5 frames at all 5 resolutions: 0 differing pixels, max abs difference 0 (the same pixel counts as the Part 3 table).

---

## Part 6: Streaming Performance

| Resolution | Implementation | Intermediate storage | Execution time (ms/frame) | Time per pixel (ns) | Speedup |
|---|---|---|---|---|---|
| 320×180 | Baseline | Complete grayscale frame (56.2 KiB) | 0.65 | 11.56 | 1.00× |
| 320×180 | Streaming | Three grayscale rows (0.94 KiB) | 0.63 | 11.22 | 1.030× |
| 1280×720 | Baseline | Complete grayscale frame (900 KiB) | 9.93 | 10.83 | 1.00× |
| 1280×720 | Streaming | Three grayscale rows (3.75 KiB) | 9.76 | 10.64 | 1.018× |
| 1920×1080 | Baseline | Complete grayscale frame (2025 KiB) | 22.07 | 10.68 | 1.00× |
| 1920×1080 | Streaming | Three grayscale rows (5.62 KiB) | 21.75 | 10.52 | 1.015× |
| 3840×2160 | Baseline | Complete grayscale frame (8100 KiB) | 87.05 | 10.51 | 1.00× |
| 3840×2160 | Streaming | Three grayscale rows (11.25 KiB) | 86.33 | 10.42 | 1.008× |
| 7680×4320 | Baseline | Complete grayscale frame (32400 KiB) | 352.58 | 10.64 | 1.00× |
| 7680×4320 | Streaming | Three grayscale rows (22.5 KiB) | 344.34 | 10.39 | 1.024× |

Times are for the full pipeline, grayscale plus Sobel. The 7680×4320 case is the one where the complete grayscale frame (31.6 MiB) exceeds every cache on the chip, including the 16 MiB L2.

**Repeatability:** a second identical run gave speedups of 0.969×, 1.011×, 1.007×, 1.002× and 1.005× at the same five resolutions. The run-to-run spread (about ±3%) is as large as the measured differences. Streaming is therefore at most a few percent faster, and within noise at most resolutions.

---

## Part 7: Discussion

**1. Why did row-major and column-major traversal perform differently when they processed the same number of elements?**
They did the same arithmetic but generated different memory traffic:
- **Row-major** reads consecutive addresses, so each 128 B cache line serves 32 accesses and the prefetcher streams lines in ahead of use.
- **Column-major** jumps N × 4 bytes per access. On large arrays each access touches a new line and a new page, uses 4 of the line's 128 bytes, and the line is usually evicted before the next column returns to it.
- At 4096×4096, column-major took 6.89 ns/element versus 0.95 ns for row-major, 7.27× slower with an identical checksum.

**2. How did array size affect the difference between the two traversal orders?**
The penalty appears only once the working set outgrows a cache level:
- **1 KiB and 64 KiB (fit in L1):** 1.00×. Every access hits L1 regardless of order.
- **4 MiB (exceeds L1, fits in L2):** 1.31×. Column-major misses L1, but the misses are served quickly from L2.
- **64 MiB and 256 MiB (exceed L2):** 7.27× and 7.51×. Column-major misses L1 on nearly every access and adds TLB misses, while row-major stays at about 0.95 ns because of prefetching.

**3. What is the difference between spatial and temporal locality? Give an example of each from this lab.**
- **Spatial locality:** after accessing an address, you soon access nearby addresses, so one cache line serves several accesses.
  - Example: row-major traversal uses all 32 integers in each 128 B line.
  - Example: `grayRowFixed` reads a color row's B, G, R bytes sequentially.
- **Temporal locality:** you access the same address again soon, while it is still cached.
  - Example: in the streaming pipeline, each grayscale row is written and then read by three consecutive Sobel output rows within about 3W bytes of work. It is reused while still in L1.
  - Example: horizontally adjacent Sobel outputs re-read 4 of the same 8 neighbors, a few instructions apart.

**4. Why are three grayscale rows sufficient for a 3×3 Sobel operator?**
Output row y (input row y+1) depends only on input rows y, y+1 and y+2, because both kernels span exactly one row above and one row below. Once output row y is done, row y is never needed again, and the next output needs only rows y+1, y+2 and y+3. At any moment only three rows are live.

**5. How much intermediate storage does the streaming implementation require as a function of width?**
**3W bytes**: three rows of W one-byte grayscale pixels, independent of height. That is 0.94 KiB at 320 wide and 22.5 KiB at 7680 wide, both small enough for L1.

**6. How much intermediate storage does the baseline require as a function of width and height?**
**W × H bytes**, the full grayscale frame: 56 KiB at 320×180, 7.9 MiB at 4K, and 31.6 MiB at 8K.

**7. Does streaming perform fewer arithmetic operations, fewer memory operations, or both?**
- **Arithmetic: identical.** WH grayscale conversions and (W−2)(H−2) Sobel evaluations, using the same kernel functions.
- **Load/store instructions: essentially identical.** Each grayscale pixel is still stored once and loaded about 8 times.
- **What changes is where those accesses go.** The grayscale stores and loads target a 3W-byte buffer that stays in L1, rather than a WH-byte frame that at high resolution must travel out to L2 or DRAM and back.
- Streaming therefore reduces memory **traffic** beyond L1 by about 2WH bytes per frame (about 66 MB at 8K), not the number of memory instructions.

**8. How did the performance difference change as resolution increased?**
It barely changed. Speedups were 1.008–1.030× at every resolution, and the second run gave 0.969–1.011×. There is no clear upward trend with resolution. The largest resolution, where the full frame exceeds L2, was about 1.02× in one run and 1.005× in the other. Time per pixel for both implementations stayed at about 10.2–11.6 ns (across both runs) over a 576× range in pixel count.

**9. Did reducing the intermediate working set produce the speedup you predicted? Explain using evidence.**
No. I expected a noticeable speedup at least at 8K, where the grayscale frame cannot stay in cache. The measurements show why it didn't happen:
- **The pipeline is limited by computation, not memory, at `-O0`.** Each output pixel costs about 10.5 ns, roughly 35 cycles of instructions: address arithmetic, loads, multiplies, shifts, `abs`, `min`, all unoptimized.
  - The pipeline needs about 6 bytes of unique data per pixel.
  - That is about 0.6 GB/s, a tiny fraction of the M2's memory bandwidth of roughly 100 GB/s.
  - Eliminating 2 of those 6 bytes per pixel saves memory time that was never the bottleneck.
- **The baseline already has excellent spatial locality.** It writes and reads the grayscale frame strictly sequentially. Part 2 showed that sequential access runs at about 0.95 ns/element even on a 256 MiB array, because the prefetcher hides DRAM latency.
- **The L2 is large.** Up to 4K, the entire grayscale frame (7.9 MiB) fits in the 16 MiB L2, so the baseline's re-read is mostly L2 hits anyway.
- **Contrast with Part 2:** the 7× penalty appeared only with large strides that defeat both cache lines and the prefetcher. The baseline pipeline never does that.
- The Part 3 result supports the same conclusion: removing instruction overhead (`.at()` calls) gave 2.7×, while removing memory traffic gave about 1%. At `-O0`, instructions dominate.

**10. What additional costs or complexity did streaming introduce?**
- A prime step for the first two rows, plus pointer rotation every row (a few instructions per row, which is negligible).
- Harder-to-verify code: the rotation order and the final-use timing of each buffer must be exactly right, or rows are silently overwritten early.
- The stages are fused, so the grayscale and Sobel stages can no longer be timed separately.
- There is no complete grayscale frame to inspect, display, save or debug.
- The stages are coupled: changing the Sobel kernel size (for example to 5×5) requires changing the number of row buffers and the priming logic.

**11. When might retaining a complete grayscale image still be the better design?**
- When the grayscale image has multiple consumers: displayed, saved, or used by other filters, histograms or feature detectors.
- When a later stage needs non-local or random access, such as a large kernel, image pyramid or multiple passes.
- When the frame fits in cache anyway, as at 4K and below on this M2, so streaming buys nothing.
- When using library routines that expect whole `cv::Mat` images.
- When parallelizing, since independent full-frame stages are simpler to split across threads.
- When clarity and debuggability matter more than a ~1% gain.

**12. Why might `-O3` change the relative performance? (prediction)**
- At `-O3` the compiler will inline the row kernels, keep values in registers, remove redundant address arithmetic, and likely auto-vectorize both loops to process 16 pixels per instruction.
- That could cut per-pixel compute time by roughly 5–10×. Memory traffic would stay the same, so it would become a much larger fraction of runtime.
- The pipeline would shift from compute-bound toward memory-bound. The 2WH bytes per frame that streaming eliminates would then matter.
- I therefore predict that streaming will show a larger speedup at `-O3` than at `-O0`, especially at 8K, where the baseline's grayscale frame must round-trip through DRAM.
- Separately, I predict the `.at()` vs `ptr()` gap will nearly disappear at `-O3` because `.at()` will be inlined.

---

## Conclusion

**Central question:** can performance be improved by reorganizing when and where data is accessed, with the math unchanged?

**Yes, when memory access is the bottleneck.** Changing only traversal order made the large-array experiment up to 7.5× faster.

**For this image pipeline at `-O0`, reorganizing data flow gave at most a few percent:**
- Streaming cut intermediate storage from WH to 3W bytes and eliminated about 2WH bytes of memory traffic per frame, but the pipeline is compute-bound.
- The baseline's access pattern was already sequential and prefetch-friendly, and the grayscale frame fits in L2 up to 4K.
- The largest measured win in the pipeline came from reducing per-access instruction overhead (`ptr()` instead of `.at()`, 2.7×), which is not a cache effect.
- Whether a memory optimization pays off depends on whether memory is actually the bottleneck, which I expect to test at `-O3`.

---

## Appendix: Raw Program Output

These are the unedited runs the tables above were taken from.

```
$ ./lab4 traversal 16 128 1024 4096 8192
Element type int32_t (4 B). Each trial visits ~67108864 elements; median of 5 trials reported.

| Dimensions | Elements | Size     | Stride   | Row ms/pass | Col ms/pass | Row ns/elem | Col ns/elem | Speedup | Checksum match          |
| 16x16      | 256      | 1.0 KiB  | 64 B     | 0.0003      | 0.0003      | 1.040       | 1.035       | 1.00x   | yes (273285883776)      |
| 128x128    | 16384    | 64.0 KiB | 512 B    | 0.0164      | 0.0164      | 0.999       | 1.004       | 1.00x   | yes (17588306960384)    |
| 1024x1024  | 1048576  | 4.0 MiB  | 4096 B   | 1.0152      | 1.3334      | 0.968       | 1.272       | 1.31x   | yes (1125898606084096)  |
| 4096x4096  | 16777216 | 64.0 MiB | 16384 B  | 15.8961     | 115.5775    | 0.947       | 6.889       | 7.27x   | yes (18014405614632960) |
| 8192x8192  | 67108864 | 256.0 MiB| 32768 B  | 63.4907     | 476.8641    | 0.946       | 7.106       | 7.51x   | yes (72057600983695360) |
```

```
$ ./lab4 pipeline ~/Downloads/bbb_sunflower_2160p_60fps_normal.mp4 5 5
Source: bbb_sunflower_2160p_60fps_normal.mp4, 5 frames at 3840x2160; 5 timed repetitions
per implementation (median reported).
Timed region: only the grayscale/Sobel computation on frames already in memory; buffers are
allocated beforehand and decode, resize, display and file output are excluded.

Part 3: Sobel pixel-access mechanism (grayscale precomputed)
| Resolution | at() ms/frame | at() ns/px | ptr ms/frame | ptr ns/px | ptr speedup |
| 320x180    | 1.380         | 24.374     | 0.507        | 8.951     | 2.72x       |
| 1280x720   | 21.283        | 23.194     | 7.946        | 8.659     | 2.68x       |
| 1920x1080  | 47.420        | 22.935     | 17.698       | 8.560     | 2.68x       |
| 3840x2160  | 190.367       | 22.985     | 70.288       | 8.486     | 2.71x       |
| 7680x4320  | 759.089       | 22.896     | 274.033      | 8.266     | 2.77x       |

Part 6: Full-frame vs streaming pipeline (grayscale + Sobel)
| Resolution | Baseline ms/frame | Baseline ns/px | Streaming ms/frame | Streaming ns/px | Speedup |
| 320x180    | 0.65              | 11.558         | 0.63               | 11.216          | 1.030x  |
| 1280x720   | 9.93              | 10.827         | 9.76               | 10.638          | 1.018x  |
| 1920x1080  | 22.07             | 10.676         | 21.75              | 10.520          | 1.015x  |
| 3840x2160  | 87.05             | 10.511         | 86.33              | 10.424          | 1.008x  |
| 7680x4320  | 352.58            | 10.635         | 344.34             | 10.386          | 1.024x  |

Correctness (all frames, every resolution; stride/ROI check also passed)
| 320x180   | at vs ptr         | 0 differing of 283020,    max abs diff 0, bit-identical: yes |
| 320x180   | full vs streaming | 0 differing of 283020,    max abs diff 0, bit-identical: yes |
| 1280x720  | at vs ptr         | 0 differing of 4588020,   max abs diff 0, bit-identical: yes |
| 1280x720  | full vs streaming | 0 differing of 4588020,   max abs diff 0, bit-identical: yes |
| 1920x1080 | at vs ptr         | 0 differing of 10338020,  max abs diff 0, bit-identical: yes |
| 1920x1080 | full vs streaming | 0 differing of 10338020,  max abs diff 0, bit-identical: yes |
| 3840x2160 | at vs ptr         | 0 differing of 41412020,  max abs diff 0, bit-identical: yes |
| 3840x2160 | full vs streaming | 0 differing of 41412020,  max abs diff 0, bit-identical: yes |
| 7680x4320 | at vs ptr         | 0 differing of 165768020, max abs diff 0, bit-identical: yes |
| 7680x4320 | full vs streaming | 0 differing of 165768020, max abs diff 0, bit-identical: yes |
```

Repeat run (same command, default 5 frames × 5 reps), Part 6 streaming speedups: 0.969×, 1.011×, 1.007×, 1.002×, 1.005×.
