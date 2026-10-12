# Lab 5: Compiler Optimization

## Setup and measurement method

**Machine:** Intel Core Ultra 9 288V (8 cores), x86-64, Ubuntu 26.04.1 LTS.  The program remains single-threaded.

**Compiler and libraries:** GNU g++ 15.2.0 and OpenCV 4 (`pkg-config opencv4`).

**Input:** the first 30 frames of `bbb_sunflower_2160p_60fps_normal.mp4`, 3840×2160.

**Method:** `lab5` reads the 30 frames before timing and preallocates all grayscale and output Mats. For each stage/configuration it runs one unreported warm-up, then reports the median of seven timed repetitions in ms/frame. Video decode, allocation, display, file output, threads, and GPU work are excluded. Grayscale, Sobel, and combined pipeline are timed separately, so the reported total is measured directly rather than calculated by adding two independently measured medians.

The current implementation in `lab5.cpp` is the optimized code from Labs 3/4: fixed-point BT.709 grayscale, row-pointer access, and `min(|Gx| + |Gy|, 255)` Sobel magnitude. The controlled Lab 2 comparison uses the actual algorithms in `lab2.cpp`: floating-point BT.601 grayscale, row-pointer Sobel, and Euclidean magnitude. For fairness, the benchmark adapts both only to write into preallocated Mats.

## Performance results

Speedup is `-O0 total time / build total time`.

| Build | Grayscale (ms/frame) | Sobel (ms/frame) | Total (ms/frame) | Speedup vs. `-O0` |
|---|---:|---:|---:|---:|
| `-O0` | 18.781 | 63.317 | 81.372 | 1.00× |
| `-O3 -fno-tree-loop-vectorize -fno-tree-slp-vectorize` | 6.605 | 14.800 | 21.615 | 3.76× |
| `-O3` | 6.628 | 14.840 | 21.734 | 3.74× |
| `-O3 -march=native` | 6.220 | 15.010 | 21.555 | 3.78× |

### `-O0` versus scalar `-O3`

With loop and SLP vectorization disabled, `-O3` reduced total time from 81.372 to 21.615 ms/frame: a **3.76×** speedup. Grayscale improved **2.84×** (18.781 → 6.605 ms), while Sobel improved **4.28×** (63.317 → 14.800 ms), so the stages were not affected equally.

Sobel benefits more because its inner loop has substantially more repeated loads, address calculations, arithmetic, and temporary values per output pixel. At `-O0`, the compiler leaves these operations in a direct source-like form with stack temporaries and repeated index calculations. Scalar `-O3` removes much of that overhead, improves register allocation, and uses pointer induction. The magnitude of the improvement is large but consistent with optimizing a 4K per-pixel loop that initially performs this extra work for every pixel.

## Assembly: scalar compiler optimization

The selected loop is the current fixed-point `grayscale` loop. `NOINLINE` keeps it as `_ZL9grayscaleRKN2cv3MatERS0_` in the generated assembly. The following excerpts come from `lab5-o0.s` and `lab5-o3-novec.s`.

`-O0` repeatedly loads `x` from the stack and recomputes `3*x` for each color component. It also spills `sum` to the stack before the store.

```asm
# -O0, inner loop excerpt
movl    -24(%rbp), %edx       # x
movl    %edx, %eax
addl    %eax, %eax
addl    %edx, %eax            # 3*x
movq    -16(%rbp), %rax       # in
addq    %rdx, %rax
movzbl  (%rax), %eax
imull   $74, %eax, %ecx
...
addl    $512, %eax
movl    %eax, -20(%rbp)       # spill sum
movl    -20(%rbp), %eax
sarl    $10, %eax
```

Scalar `-O3` instead advances the input pointer by three bytes per iteration, keeps the accumulator in registers, and forms the final addition with one `lea` instruction.

```asm
# -O3 with vectorization disabled, inner loop excerpt
movzbl  (%rdx), %eax
movzbl  1(%rdx), %esi
addq    $3, %rdx              # advance BGR pointer
imull   $732, %esi, %esi
imull   $74, %eax, %eax
addl    %esi, %eax
movzbl  -1(%rdx), %esi
imull   $218, %esi, %esi
leal    512(%rax,%rsi), %eax  # add R term and rounding constant
sarl    $10, %eax
movb    %al, (%r8,%rcx)
```

Two visible optimizations are: (1) **strength reduction / induction variables**—the repeated `3*x` calculation becomes `addq $3, %rdx`; and (2) **register allocation and dead-store elimination**—`sum` is never written to or reloaded from the stack. The optimized code also combines an addition with address-generation hardware (`leal`). These reduce instruction count, memory traffic, and loop-carried overhead, explaining the large scalar `-O3` speedup.

## Automatic SIMD vectorization

| Build | Grayscale (ms/frame) | Sobel (ms/frame) | Total (ms/frame) |
|---|---:|---:|---:|
| `-O3`, vectorization disabled | 6.605 | 14.800 | 21.615 |
| `-O3` | 6.628 | 14.840 | 21.734 |

Enabling automatic vectorization produced **no measured improvement**: normal `-O3` was 0.55% slower overall (21.734 versus 21.615 ms/frame), well within ordinary benchmark variation.

There is also no evidence that GCC vectorized either important pixel loop. The `grayscale` and `sobel` functions in `lab5-o3.s` and `lab5-o3-novec.s` have the same scalar inner-loop instructions (`movzbl`, `imull`, `addl`, `sarl`, and `movb`); the differences are only compiler-generated temporary names/comments. In particular, the grayscale loop advances one BGR pixel at a time with `addq $3, %rdx`, rather than operating on multiple pixels in vector registers. The Sobel loop is likewise scalar.

```asm
# grayscale inner loop in both lab5-o3-novec.s and lab5-o3.s
movzbl  (%rdx), %eax
movzbl  1(%rdx), %esi
addq    $3, %rdx
imull   $732, %esi, %esi
imull   $74, %eax, %eax
leal    512(%rax,%rsi), %eax
movb    %al, (%r8,%rcx)
```

Some `xmm` instructions occur elsewhere in the program for scalar floating-point timing/median code. They are not evidence of SIMD processing in the image loops. Thus, **neither grayscale nor Sobel benefits measurably from automatic SIMD in this build**, and the amount of the overall compiler speedup attributable to SIMD is approximately zero. The interleaved three-byte BGR layout and overlapping Sobel neighborhoods likely make these loops harder for the compiler to vectorize safely and profitably.

## `-march=native`

| Build | Grayscale (ms/frame) | Sobel (ms/frame) | Total (ms/frame) |
|---|---:|---:|---:|
| `-O3` | 6.628 | 14.840 | 21.734 |
| `-O3 -march=native` | 6.220 | 15.010 | 21.555 |

`-march=native` made the combined pipeline only **0.83% faster** (1.008×), which is too small to call a meaningful overall change from this data. Grayscale was 6.6% faster, but Sobel was 1.1% slower; the net result is small.

Comparing `lab5-o3.s` with `lab5-native.s` shows minor instruction scheduling and AVX-encoded scalar instructions in surrounding runtime/median code (`vmovsd`, `vcomisd`, and similar). The grayscale and Sobel pixel loops remain scalar; no vector-across-pixels instructions appear in them. `-march=native` tells GCC to tune for the build CPU and enable that CPU's available instruction-set extensions. A distributed precompiled binary normally avoids it because the enabled instructions may be unsupported on a customer's older or different CPU.

## Do source-level optimizations still matter under `-O3`?

| Source version, both `-O3` | Grayscale (ms/frame) | Sobel (ms/frame) | Total (ms/frame) | Speedup vs. Lab 2 |
|---|---:|---:|---:|---:|
| Lab 2 baseline | 25.268 | 23.499 | 49.022 | 1.00× |
| Current implementation | 6.628 | 14.840 | 21.734 | 2.26× |

Source-level work remains important after aggressive compilation: the current version is **2.26× faster overall**, with a **3.81×** grayscale speedup and a **1.58×** Sobel speedup versus the Lab 2 source at the same `-O3` level.

The compiler can reproduce low-level consequences of clear source code, including constant folding, strength reduction, register allocation, inlining of small accessors, and loop-invariant/address hoisting. It cannot safely decide to change the Lab 2 floating-point BT.601 formula into the current fixed-point BT.709 approximation, or replace exact Euclidean magnitude with `|Gx| + |Gy|`: both are algorithm/accuracy decisions that change numerical output and require programmer intent. Both source versions already use row pointers, so row-pointer access is not responsible for this controlled speedup. The programmer supplies the algorithm, data representation, and acceptable accuracy trade-off; the compiler then efficiently maps those choices to machine code.

## Submission contents

- `lab2.cpp` (actual Lab 2 baseline), `lab5.cpp`, and `Makefile`
- This report with the four-build measurements and controlled source comparison
- `lab5-o0.s` and `lab5-o3-novec.s` excerpts above, plus `lab5-o3.s`/`lab5-native.s` for the vectorization and native-target comparisons
