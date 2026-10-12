	.file	"lab5.cpp"
# GNU C++17 (Ubuntu 15.2.0-16ubuntu1) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -march=arrowlake-s -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512vbmi -mno-avx512ifma -mno-avx512vpopcntdq -mno-avx512vbmi2 -mgfni -mvpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mpconfig -mpku -mprfchw -mptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mserialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mwaitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -muintr -mhreset -mno-kl -mno-widekl -mavxvnni -mno-avx512fp16 -mavxifma -mavxvnniint8 -mavxneconvert -mcmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex -mavxvnniint16 -msm3 -msha512 -msm4 -mno-apxf -mno-usermsr -mno-avx10.2 -mno-amx-avx512 -mno-amx-tf32 -mno-amx-transpose -mno-amx-fp8 -mno-movrs -mno-amx-movrs --param=l1-cache-size=48 --param=l1-cache-line-size=64 --param=l2-cache-size=12288 -mtune=arrowlake-s -O3 -std=c++17 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZL9grayscaleRKN2cv3MatERS0_, @function
_ZL9grayscaleRKN2cv3MatERS0_:
.LFB17230:
	.cfi_startproc
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	movl	8(%rdi), %eax	# color_31(D)->rows,
# lab5.cpp:68: NOINLINE static void grayscale(const cv::Mat& color, cv::Mat& gray) {
	movq	%rsi, %r10	# gray, gray
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	testl	%eax, %eax	#
	jle	.L9	#,
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	movl	12(%rdi), %eax	# color_31(D)->cols, _24
	xorl	%r9d, %r9d	# ivtmp.614
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	testl	%eax, %eax	# _24
	jle	.L9	#,
	.p2align 4,,10
	.p2align 3
.L11:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	movq	72(%r10), %rax	# gray_33(D)->step.p, gray_33(D)->step.p
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	xorl	%ecx, %ecx	# ivtmp.607
	movq	(%rax), %r8	# *_32, _40
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	72(%rdi), %rax	# color_31(D)->step.p, color_31(D)->step.p
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	imulq	%r9, %r8	# ivtmp.614, _40
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	(%rax), %rdx	# *_42, _45
	imulq	%r9, %rdx	# ivtmp.614, _45
	addq	16(%r10), %r8	# gray_33(D)->data, _95
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	addq	16(%rdi), %rdx	# color_31(D)->data, ivtmp.609
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L4:
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	movzbl	(%rdx), %eax	# MEM[(const uchar *)_92], _5
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	movzbl	1(%rdx), %esi	# MEM[(const uchar *)_92 + 1B], _11
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	imull	$74, %eax, %eax	#, _5, _6
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	imull	$732, %esi, %esi	#, _11, _12
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	addq	$3, %rdx	#, ivtmp.609
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	addl	%esi, %eax	# _12, _13
# lab5.cpp:74:                           + 218 * in[3 * x + 2] + 512;
	movzbl	-1(%rdx), %esi	# MEM[(const uchar *)_92 + 2B], _17
# lab5.cpp:74:                           + 218 * in[3 * x + 2] + 512;
	imull	$218, %esi, %esi	#, _17, _18
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	leal	512(%rax,%rsi), %eax	#, sum_36
# lab5.cpp:75:             out[x] = static_cast<uchar>(sum >> 10);
	sarl	$10, %eax	#, _20
# lab5.cpp:75:             out[x] = static_cast<uchar>(sum >> 10);
	movb	%al, (%r8,%rcx)	# _20, MEM[(uchar *)_95 + ivtmp.607_129 * 1]
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	addq	$1, %rcx	#, ivtmp.607
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	movl	12(%rdi), %eax	# color_31(D)->cols, _24
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	cmpl	%ecx, %eax	# ivtmp.607, _24
	jg	.L4	#,
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	leal	1(%r9), %edx	#, _38
	cmpl	8(%rdi), %edx	# color_31(D)->rows, _38
	jge	.L9	#,
	addq	$1, %r9	#, ivtmp.614
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	testl	%eax, %eax	# _24
	jg	.L11	#,
.L9:
# lab5.cpp:78: }
	ret	
	.cfi_endproc
.LFE17230:
	.size	_ZL9grayscaleRKN2cv3MatERS0_, .-_ZL9grayscaleRKN2cv3MatERS0_
	.p2align 4
	.type	_ZL5sobelRKN2cv3MatERS0_, @function
_ZL5sobelRKN2cv3MatERS0_:
.LFB17231:
	.cfi_startproc
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	cmpl	$2, 8(%rdi)	#, gray_57(D)->rows
	jle	.L22	#,
# lab5.cpp:80: NOINLINE static void sobel(const cv::Mat& gray, cv::Mat& out) {
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdi, %r11	# gray, gray
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rsi, %rbp	# out, out
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	movl	$1, %ebx	#, ivtmp.632
	movl	12(%rdi), %edx	# gray_57(D)->cols, _48
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	$2, %edx	#, _48
	jle	.L20	#,
	.p2align 4,,10
	.p2align 3
.L25:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	72(%r11), %rax	# gray_57(D)->step.p, gray_57(D)->step.p
	leaq	-1(%rbx), %r10	#, _401
	movq	(%rax), %rdx	# *_75, _76
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	16(%r11), %rsi	# gray_57(D)->data, _74
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	%rdx, %rax	# _76, _72
	imulq	%rbx, %rax	# ivtmp.632, _72
	movq	%rdx, %rdi	# _76, _78
	imulq	%r10, %rdi	# _401, _78
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	leaq	(%rsi,%rax), %r9	#, _73
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	addq	%rdx, %rax	# _76, _69
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	addq	%rsi, %rdi	# _74, _79
	addq	%rax, %rsi	# _69, _70
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	movq	72(%rbp), %rax	# out_60(D)->step.p, out_60(D)->step.p
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	imulq	(%rax), %r10	# *_61, _58
	xorl	%eax, %eax	# ivtmp.622
	addq	16(%rbp), %r10	# out_60(D)->data, _406
	.p2align 4,,10
	.p2align 3
.L15:
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	(%rdi,%rax), %r13d	# MEM[(const uchar *)_79 + ivtmp.622_408 * 1], _10
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movzbl	1(%rdi,%rax), %r14d	# MEM[(const uchar *)_79 + 1B + ivtmp.622_408 * 1], _33
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movl	%r13d, %edx	# _10, _29
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%rdi,%rax), %ecx	# MEM[(const uchar *)_79 + 2B + ivtmp.622_408 * 1], _7
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	addl	%r14d, %r14d	# _34
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	negl	%edx	# _29
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	(%rsi,%rax), %r12d	# MEM[(const uchar *)_70 + ivtmp.622_408 * 1], _24
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	subl	%r14d, %edx	# _34, _35
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	subl	%ecx, %edx	# _7, _36
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movzbl	1(%rsi,%rax), %r14d	# MEM[(const uchar *)_70 + 1B + ivtmp.622_408 * 1], _40
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%rsi,%rax), %r8d	# MEM[(const uchar *)_70 + 2B + ivtmp.622_408 * 1], _28
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	addl	%r12d, %edx	# _24, _37
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	leal	(%rdx,%r14,2), %r14d	#, _42
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	addl	%r8d, %r14d	# _28, gy_63
# lab5.cpp:89:             const int magnitude = std::abs(gx) + std::abs(gy);
	movl	%r14d, %edx	# gy_63, tmp193
	negl	%edx	# tmp193
	cmovs	%r14d, %edx	# tmp193,, gy_63, _44
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	subl	%r13d, %ecx	# _10, _11
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	(%r9,%rax), %r13d	# MEM[(const uchar *)_73 + ivtmp.622_408 * 1], _14
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	addl	%r13d, %r13d	# _15
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	subl	%r13d, %ecx	# _15, _16
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%r9,%rax), %r13d	# MEM[(const uchar *)_73 + 2B + ivtmp.622_408 * 1], _19
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	leal	(%rcx,%r13,2), %ecx	#, _21
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	subl	%r12d, %ecx	# _24, _25
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	addl	%r8d, %ecx	# _28, gx_62
# lab5.cpp:89:             const int magnitude = std::abs(gx) + std::abs(gy);
	movl	%ecx, %r8d	# gx_62, tmp194
	negl	%r8d	# tmp194
	cmovns	%r8d, %ecx	# tmp194,, _43
# lab5.cpp:89:             const int magnitude = std::abs(gx) + std::abs(gy);
	addl	%ecx, %edx	# _43, _45
# /usr/include/c++/15/bits/stl_algobase.h:239:       if (__b < __a)
	movl	$255, %ecx	#, tmp195
	cmpl	%ecx, %edx	# tmp195, _45
	cmovg	%ecx, %edx	# _45,, tmp195, _45
# lab5.cpp:90:             dst[x] = static_cast<uchar>(std::min(magnitude, 255));
	movb	%dl, (%r10,%rax)	# _45, MEM[(uchar *)_406 + ivtmp.622_408 * 1]
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	addq	$1, %rax	#, ivtmp.622
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	movl	12(%r11), %edx	# gray_57(D)->cols, _48
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	leal	-2(%rdx), %ecx	#, _49
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	%eax, %ecx	# ivtmp.622, _49
	jg	.L15	#,
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	movl	8(%r11), %eax	# gray_57(D)->rows, tmp202
	subl	$2, %eax	#, _17
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	cmpl	%ebx, %eax	# ivtmp.632, _17
	jle	.L20	#,
	addq	$1, %rbx	#, ivtmp.632
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	$2, %edx	#, _48
	jg	.L25	#,
.L20:
# lab5.cpp:93: }
	popq	%rbx	#
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
.L22:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE17231:
	.size	_ZL5sobelRKN2cv3MatERS0_, .-_ZL5sobelRKN2cv3MatERS0_
	.p2align 4
	.type	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, @function
_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0:
.LFB22239:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	leaq	-1(%rdx), %r10	#, tmp143
	shrq	$63, %r10	#, tmp143
	leaq	-1(%r10,%rdx), %r10	#, tmp144
	sarq	%r10	# _71
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	cmpq	%r10, %rsi	# _71, __holeIndex
# /usr/include/c++/15/bits/stl_heap.h:224:     __adjust_heap(_RandomAccessIterator __first, _Distance __holeIndex,
	movq	%rsi, %r8	# __holeIndex, __holeIndex
	movq	%rdx, %r11	# __len, __len
	vmovapd	%xmm0, %xmm2	# __value, __value
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	jge	.L27	#,
	movq	%rsi, %rdx	# __holeIndex, __holeIndex
	jmp	.L30	#
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L36:
	movq	%rcx, %rdx	# __secondChild, __holeIndex
.L30:
# /usr/include/c++/15/bits/stl_heap.h:231: 	  __secondChild = 2 * (__secondChild + 1);
	leaq	1(%rdx), %rax	#, _119
# /usr/include/c++/15/bits/stl_heap.h:231: 	  __secondChild = 2 * (__secondChild + 1);
	leaq	(%rax,%rax), %rcx	#, __secondChild
# /usr/include/c++/15/bits/stl_heap.h:232: 	  if (__comp(__first + __secondChild,
	leaq	-1(%rcx), %rsi	#, _117
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	salq	$4, %rax	#, _105
	addq	%rdi, %rax	# __first, prephitmp_100
	leaq	(%rdi,%rsi,8), %r9	#, _107
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	(%rax), %xmm0	# *_104, prephitmp_99
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	(%r9), %xmm1	# *_107, _102
# /usr/include/c++/15/bits/stl_heap.h:232: 	  if (__comp(__first + __secondChild,
	vcomisd	%xmm0, %xmm1	# prephitmp_99, _102
# /usr/include/c++/15/bits/stl_heap.h:234: 	    __secondChild--;
	vmaxsd	%xmm0, %xmm1, %xmm0	# prephitmp_99, _102, prephitmp_99
	cmova	%rsi, %rcx	# _117,, __secondChild
	cmova	%r9, %rax	# _107,, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	cmpq	%rcx, %r10	# __secondChild, _71
# /usr/include/c++/15/bits/stl_heap.h:235: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first + __secondChild));
	vmovsd	%xmm0, (%rdi,%rdx,8)	# prephitmp_99, *_96
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	jg	.L36	#,
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	testb	$1, %r11b	#, __len
	je	.L43	#,
.L31:
# /usr/include/c++/15/bits/stl_heap.h:139:       _Distance __parent = (__holeIndex - 1) / 2;
	leaq	-1(%rcx), %rdx	#, tmp155
	shrq	$63, %rdx	#, tmp155
	leaq	-1(%rdx,%rcx), %rdx	#, tmp156
	sarq	%rdx	# __parent
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	cmpq	%r8, %rcx	# __holeIndex, __secondChild
	jg	.L34	#,
	jmp	.L32	#
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L45:
# /usr/include/c++/15/bits/stl_heap.h:142: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first + __parent));
	vmovsd	%xmm0, (%rax)	# _47, *_151
# /usr/include/c++/15/bits/stl_heap.h:144: 	  __parent = (__holeIndex - 1) / 2;
	leaq	-1(%rdx), %rax	#, tmp160
	shrq	$63, %rax	#, tmp160
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	cmpq	%rdx, %r8	# __parent, __holeIndex
# /usr/include/c++/15/bits/stl_heap.h:144: 	  __parent = (__holeIndex - 1) / 2;
	leaq	-1(%rax,%rdx), %rax	#, tmp161
	movq	%rdx, %rcx	# __parent, __secondChild
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	jge	.L44	#,
	sarq	%rax	# tmp161
	movq	%rax, %rdx	# tmp161, __parent
.L34:
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rdx,8), %rsi	#, _46
# /usr/include/c++/15/bits/predefined_ops.h:69:       { return *__it < __val; }
	vmovsd	(%rsi), %xmm0	# *_46, _47
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rcx,8), %rax	#, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	vcomisd	%xmm0, %xmm2	# _47, __value
	ja	.L45	#,
.L32:
# /usr/include/c++/15/bits/stl_heap.h:146:       *(__first + __holeIndex) = _GLIBCXX_MOVE(__value);
	vmovsd	%xmm2, (%rax)	# __value, *prephitmp_148
# /usr/include/c++/15/bits/stl_heap.h:249:     }
	ret	
	.p2align 4,,10
	.p2align 3
.L43:
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	subq	$2, %r11	#, _26
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	sarq	%r11	# _27
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	cmpq	%rcx, %r11	# __secondChild, _27
	jne	.L31	#,
.L35:
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	leaq	1(%rcx,%rcx), %rcx	#, __secondChild
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rcx,8), %rdx	#, _33
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	vmovsd	(%rdx), %xmm0	# MEM[(type &)_33], _34
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	vmovsd	%xmm0, (%rax)	# _34, *prephitmp_5
	movq	%rdx, %rax	# _33, prephitmp_100
	jmp	.L31	#
	.p2align 4,,10
	.p2align 3
.L44:
	movq	%rsi, %rax	# _46, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:146:       *(__first + __holeIndex) = _GLIBCXX_MOVE(__value);
	vmovsd	%xmm2, (%rax)	# __value, *prephitmp_148
# /usr/include/c++/15/bits/stl_heap.h:249:     }
	ret	
	.p2align 4,,10
	.p2align 3
.L27:
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	testb	$1, %dl	#, __len
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rsi,8), %rax	#, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	jne	.L32	#,
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	subq	$2, %r11	#, _137
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	sarq	%r11	# _138
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	cmpq	%r11, %rsi	# _138, __holeIndex
	jne	.L32	#,
	movq	%r8, %rcx	# __holeIndex, __secondChild
	jmp	.L35	#
	.cfi_endproc
.LFE22239:
	.size	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, .-_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0
	.p2align 4
	.type	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0, @function
_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0:
.LFB22240:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_algo.h:1774:       if (__first == __last) return;
	cmpq	%rsi, %rdi	# __last, __first
	je	.L67	#,
# /usr/include/c++/15/bits/stl_algo.h:1771:     __insertion_sort(_RandomAccessIterator __first,
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12	# __last, __last
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp	# __first, __first
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	8(%rdi), %rbx	#, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1771:     __insertion_sort(_RandomAccessIterator __first,
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	cmpq	%rbx, %rsi	# __i$_M_current, __last
	jne	.L56	#,
	jmp	.L65	#
	.p2align 4,,10
	.p2align 3
.L70:
# /usr/include/c++/15/bits/stl_iterator_base_funcs.h:108:       return __last - __first;
	movq	%rbx, %rdx	# __i$_M_current, _23
	subq	%rbp, %rdx	# __first, _23
# /usr/include/c++/15/bits/stl_iterator_base_funcs.h:197: 	__i += __n;
	movq	%rdx, %rax	# _23, tmp116
	salq	$61, %rax	#, tmp116
	subq	%rdx, %rax	# _23, _30
# /usr/include/c++/15/bits/stl_algobase.h:702: 	  if (__builtin_expect(__n > 1, true))
	cmpq	$8, %rdx	#, _23
# /usr/include/c++/15/bits/stl_iterator_base_funcs.h:197: 	__i += __n;
	leaq	8(%rbx,%rax), %rdi	#, _31
# /usr/include/c++/15/bits/stl_algobase.h:702: 	  if (__builtin_expect(__n > 1, true))
	jle	.L50	#,
# /usr/include/c++/15/bits/stl_algobase.h:704: 	      __builtin_memmove(_GLIBCXX_TO_ADDR(__result),
	movq	%rbp, %rsi	# __first,
	vmovsd	%xmm1, 8(%rsp)	# _5, %sfp
	call	memmove@PLT	#
	vmovsd	8(%rsp), %xmm1	# %sfp, _5
.L51:
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	cmpq	%rbx, %r12	# __i$_M_current, __last
# /usr/include/c++/15/bits/stl_algo.h:1783: 	      *__first = _GLIBCXX_MOVE(__val);
	vmovsd	%xmm1, 0(%rbp)	# _5, *__first_1
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	je	.L65	#,
.L56:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	(%rbx), %xmm1	# MEM[(double &)__i$_M_current_26], _5
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	0(%rbp), %xmm0	# *__first_1, _6
# /usr/include/c++/15/bits/stl_algo.h:1778: 	  if (__comp(__i, __first))
	vcomisd	%xmm1, %xmm0	# _5, _6
	ja	.L70	#,
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	vmovsd	-8(%rbx), %xmm0	# MEM[(double &)__i$_M_current_26 + 18446744073709551608], _9
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	leaq	-8(%rbx), %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	vcomisd	%xmm1, %xmm0	# _5, _9
	jbe	.L64	#,
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L55:
# /usr/include/c++/15/bits/stl_algo.h:1760: 	  *__last = _GLIBCXX_MOVE(*__next);
	vmovsd	%xmm0, 8(%rax)	# _9, MEM[(double &)__next$_M_current_7 + 8]
	movq	%rax, %rdx	# __next$_M_current, __last$_M_current
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	vmovsd	-8(%rax), %xmm0	# MEM[(double &)_12], _9
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	vcomisd	%xmm1, %xmm0	# _5, _9
	ja	.L55	#,
.L53:
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	cmpq	%rbx, %r12	# __i$_M_current, __last
# /usr/include/c++/15/bits/stl_algo.h:1764:       *__last = _GLIBCXX_MOVE(__val);
	vmovsd	%xmm1, (%rdx)	# _5, *__last$_M_current_34
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	jne	.L56	#,
.L65:
# /usr/include/c++/15/bits/stl_algo.h:1789:     }
	addq	$16, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L50:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_algobase.h:708: 	  else if (__n == 1)
	jne	.L51	#,
# /usr/include/c++/15/bits/stl_algobase.h:404: 	*__out = std::move(*__in);
	vmovsd	%xmm0, (%rdi)	# _6, *_31
# /usr/include/c++/15/bits/stl_algobase.h:408:     }
	jmp	.L51	#
.L64:
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	movq	%rbx, %rdx	# __i$_M_current, __last$_M_current
	jmp	.L53	#
.L67:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret	
	.cfi_endproc
.LFE22240:
	.size	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0, .-_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0
	.p2align 4
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0, @function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0:
.LFB22242:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rsi, %rax	# __last, _7
	subq	%rdi, %rax	# __first, _7
# /usr/include/c++/15/bits/stl_algo.h:1881:       while (__last - __first > int(_S_threshold))
	cmpq	$128, %rax	#, _7
	jle	.L122	#,
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rax, %r14	# _7, _163
	sarq	$3, %r14	#, _163
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdx, %r13	# __depth_limit, __depth_limit
	sarq	$4, %rax	#, _164
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
# /usr/include/c++/15/bits/stl_algo.h:1883: 	  if (__depth_limit == 0)
	testq	%r13, %r13	# __depth_limit
	movq	%rsi, %r12	# __last, __last
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp	# __first, __first
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# /usr/include/c++/15/bits/stl_algo.h:1883: 	  if (__depth_limit == 0)
	je	.L123	#,
.L73:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovupd	0(%rbp), %xmm2	# MEM <vector(2) double> [(type &)__first_9], MEM <vector(2) double> [(type &)__first_9]
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	0(%rbp,%rax,8), %rax	#, _63
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	(%rax), %xmm3	# *_63, _80
	vunpckhpd	%xmm2, %xmm2, %xmm0	# MEM <vector(2) double> [(type &)__first_9], pretmp_81
# /usr/include/c++/15/bits/stl_algo.h:1888: 	  --__depth_limit;
	subq	$1, %r13	#, __depth_limit
# /usr/include/c++/15/bits/stl_algo.h:91:       if (__comp(__a, __b))
	vcomisd	%xmm0, %xmm3	# pretmp_81, _80
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	-8(%r12), %xmm4	# MEM[(double &)__last_118 + 18446744073709551608], pretmp_161
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	8(%rbp), %rbx	#, __first$_M_current
	vmovapd	%xmm2, %xmm1	# MEM <vector(2) double> [(type &)__first_9], prephitmp_83
# /usr/include/c++/15/bits/stl_algo.h:91:       if (__comp(__a, __b))
	jbe	.L111	#,
# /usr/include/c++/15/bits/stl_algo.h:93: 	  if (__comp(__b, __c))
	vcomisd	%xmm3, %xmm4	# _80, pretmp_161
	ja	.L113	#,
# /usr/include/c++/15/bits/stl_algo.h:95: 	  else if (__comp(__a, __c))
	vcomisd	%xmm0, %xmm4	# pretmp_81, pretmp_161
	ja	.L120	#,
.L85:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	vpermilpd	$1, %xmm2, %xmm2	#, MEM <vector(2) double> [(type &)__first_9], _45
	vmovupd	%xmm2, 0(%rbp)	# _45, MEM <vector(2) double> [(double &)__first_9]
.L84:
	movq	%r12, %rdx	# __last, __last$_M_current
	jmp	.L121	#
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L92:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	8(%rbx), %xmm1	# MEM[(double &)_67], prephitmp_83
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __first$_M_current
.L121:
# /usr/include/c++/15/bits/stl_algo.h:1836: 	  while (__comp(__first, __pivot))
	vcomisd	%xmm1, %xmm0	# prephitmp_83, pretmp_81
	ja	.L92	#,
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	-8(%rdx), %xmm2	# MEM[(double &)__last$_M_current_70 + 18446744073709551608], _74
	leaq	-16(%rdx), %rax	#, ivtmp.701
# /usr/include/c++/15/bits/stl_algo.h:1839: 	  while (__comp(__pivot, __last))
	vcomisd	%xmm0, %xmm2	# pretmp_81, _74
	jbe	.L114	#,
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L95:
	movq	%rax, %rdx	# ivtmp.701, ivtmp.701
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	(%rax), %xmm2	# MEM[(double &)_142 + 8], _74
# /usr/include/c++/15/bits/stl_algo.h:1839: 	  while (__comp(__pivot, __last))
	subq	$8, %rax	#, ivtmp.701
	vcomisd	%xmm0, %xmm2	# pretmp_81, _74
	ja	.L95	#,
# /usr/include/c++/15/bits/stl_algo.h:1841: 	  if (!(__first < __last))
	cmpq	%rdx, %rbx	# __last$_M_current, __first$_M_current
	jnb	.L124	#,
.L97:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	vmovsd	%xmm2, (%rbx)	# _74, *__first$_M_current_41
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	vmovsd	%xmm1, (%rdx)	# prephitmp_83, *__last$_M_current_130
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	8(%rbx), %xmm1	# MEM[(double &)__first$_M_current_41 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __first$_M_current
# /usr/include/c++/15/bits/stl_iterator.h:1104: 	return *this;
	jmp	.L121	#
.L111:
# /usr/include/c++/15/bits/stl_algo.h:100:       else if (__comp(__a, __c))
	vcomisd	%xmm0, %xmm4	# pretmp_81, pretmp_161
	ja	.L85	#,
# /usr/include/c++/15/bits/stl_algo.h:102:       else if (__comp(__b, __c))
	vcomisd	%xmm3, %xmm4	# _80, pretmp_161
	jbe	.L113	#,
.L120:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	vmovsd	%xmm4, 0(%rbp)	# pretmp_161, *__first_9
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	vmovsd	%xmm1, -8(%r12)	# prephitmp_83, MEM[(double &)__last_118 + 18446744073709551608]
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	8(%rbp), %xmm1	# MEM[(double &)__first_9 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
	jmp	.L84	#
	.p2align 4,,10
	.p2align 3
.L114:
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rdx	#, __last$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1841: 	  if (!(__first < __last))
	cmpq	%rdx, %rbx	# __last$_M_current, __first$_M_current
	jb	.L97	#,
	.p2align 4,,10
	.p2align 3
.L124:
# /usr/include/c++/15/bits/stl_algo.h:1891: 	  std::__introsort_loop(__cut, __last, __depth_limit, __comp);
	movq	%r13, %rdx	# __depth_limit,
	movq	%r12, %rsi	# __last,
	movq	%rbx, %rdi	# __first$_M_current,
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0	#
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rbx, %rax	# __first$_M_current, _7
	subq	%rbp, %rax	# __first, _7
# /usr/include/c++/15/bits/stl_algo.h:1881:       while (__last - __first > int(_S_threshold))
	cmpq	$128, %rax	#, _7
	jle	.L115	#,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rax, %r14	# _7, _163
	sarq	$3, %r14	#, _163
	sarq	$4, %rax	#, _164
# /usr/include/c++/15/bits/stl_algo.h:1883: 	  if (__depth_limit == 0)
	testq	%r13, %r13	# __depth_limit
	movq	%rbx, %r12	# __first$_M_current, __last
	jne	.L73	#,
.L123:
# /usr/include/c++/15/bits/stl_heap.h:352:       _DistanceType __parent = (__len - 2) / 2;
	leaq	-1(%rax), %rbx	#, __parent
	jmp	.L75	#
.L125:
# /usr/include/c++/15/bits/stl_heap.h:360: 	  __parent--;
	subq	$1, %rbx	#, __parent
.L75:
# /usr/include/c++/15/bits/stl_heap.h:355: 	  _ValueType __value = _GLIBCXX_MOVE(*(__first + __parent));
	vmovsd	0(%rbp,%rbx,8), %xmm0	# MEM[(type &)__first_9 + _106 * 8], _54
# /usr/include/c++/15/bits/stl_heap.h:356: 	  std::__adjust_heap(__first, __parent, __len, _GLIBCXX_MOVE(__value),
	movq	%r14, %rdx	# _163,
	movq	%rbx, %rsi	# __parent,
	movq	%rbp, %rdi	# __first,
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0	#
# /usr/include/c++/15/bits/stl_heap.h:358: 	  if (__parent == 0)
	testq	%rbx, %rbx	# __parent
	jne	.L125	#,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rax	# __last, _42
	subq	%rbp, %rax	# __first, _42
# /usr/include/c++/15/bits/stl_heap.h:422:       while (__last - __first > 1)
	cmpq	$8, %rax	#, _42
	leaq	-8(%r12), %rbx	#, ivtmp.680
	jle	.L115	#,
	.p2align 4,,10
	.p2align 3
.L78:
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rbx, %r12	# ivtmp.680, _32
# /usr/include/c++/15/bits/stl_heap.h:263:       *__result = _GLIBCXX_MOVE(*__first);
	vmovsd	0(%rbp), %xmm1	# MEM[(type &)__first_9], _31
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	subq	%rbp, %r12	# __first, _32
# /usr/include/c++/15/bits/stl_heap.h:262:       _ValueType __value = _GLIBCXX_MOVE(*__result);
	vmovsd	(%rbx), %xmm0	# MEM[(type &)_28], _29
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rdx	# _32, _33
# /usr/include/c++/15/bits/stl_heap.h:263:       *__result = _GLIBCXX_MOVE(*__first);
	vmovsd	%xmm1, (%rbx)	# _31, MEM[(double &)_28]
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	sarq	$3, %rdx	#, _33
# /usr/include/c++/15/bits/stl_heap.h:264:       std::__adjust_heap(__first, _DistanceType(0),
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# __first,
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0	#
# /usr/include/c++/15/bits/stl_heap.h:422:       while (__last - __first > 1)
	subq	$8, %rbx	#, ivtmp.680
	cmpq	$8, %r12	#, _32
	jg	.L78	#,
.L115:
# /usr/include/c++/15/bits/stl_algo.h:1894:     }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
.L113:
	.cfi_restore_state
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	vmovsd	%xmm3, 0(%rbp)	# _80, *__first_9
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	vmovsd	%xmm1, (%rax)	# prephitmp_83, *_63
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	8(%rbp), %xmm1	# MEM[(double &)__first_9 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	vmovsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
	jmp	.L84	#
.L122:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE22242:
	.size	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0, .-_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"vector::_M_realloc_append"
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB3:
	.text
.LHOTB3:
	.align 2
	.p2align 4
	.type	_ZZ4mainENKUliE_clEi, @function
_ZZ4mainENKUliE_clEi:
.LFB17250:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA17250
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movq	(%rdi), %rax	# __closure_18(D)->__reps, __closure_18(D)->__reps
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movl	(%rax), %edx	# *_97,
	testl	%edx, %edx	#
	js	.L165	#,
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	xorl	%r13d, %r13d	# __new_finish
	cmpl	$1, %esi	#, stage
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 16(%rsp)	#, %sfp
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 24(%rsp)	#, %sfp
	movq	%rdi, %r14	# __closure, __closure
	movl	%esi, %ebp	# stage, stage
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movl	$-1, %r12d	#, r
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rbx	#, tmp297
	je	.L202	#,
	.p2align 4,,10
	.p2align 3
.L128:
# lab5.cpp:129:             const auto start = Clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
	movq	%rax, 8(%rsp)	#, %sfp
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rax	# __closure_18(D)->__color, _126
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r15d, %r15d	# i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rax), %rsi	# MEM[(const struct vector *)_126].D.132534._M_impl.D.131869._M_start, _131
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rax), %rax	# MEM[(const struct vector *)_126].D.132534._M_impl.D.131869._M_finish, MEM[(const struct vector *)_126].D.132534._M_impl.D.131869._M_finish
	subq	%rsi, %rax	# _131, _210
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp295
	imulq	%rbx, %rax	# tmp297, __dif
	jmp	.L142	#
	.p2align 4,,10
	.p2align 3
.L145:
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
	leaq	(%r15,%r15,2), %r11	#, _72
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rcx	# pretmp_307->D.132534._M_impl.D.131869._M_start, _310
	salq	$5, %r11	#, tmp301
	addq	%r11, %rcx	# tmp301, _310
	leaq	(%rsi,%r11), %rdi	#, _28
# lab5.cpp:131:                 if (stage != 1) grayscale(color[i], gray[i]);
	movq	%rcx, %rsi	# _310,
	call	_ZL9grayscaleRKN2cv3MatERS0_	#
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	testl	%ebp, %ebp	# stage
	je	.L143	#,
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	24(%r14), %rax	# __closure_18(D)->__edges, __closure_18(D)->__edges
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rsi	# _2->D.132534._M_impl.D.131869._M_start, _47
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%r11, %rsi	# tmp301, _47
	movq	(%rax), %rdi	# _3->D.132534._M_impl.D.131869._M_start, tmp301
	addq	%r11, %rdi	# tmp301, tmp301
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	call	_ZL5sobelRKN2cv3MatERS0_	#
.L143:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rax	# __closure_18(D)->__color, _4
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r15	#, i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rax), %rsi	#* _4, _131
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rax), %rax	#, MEM[(const struct vector *)_4].D.132534._M_impl.D.131869._M_finish
	subq	%rsi, %rax	# _131, _50
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp319
	imulq	%rbx, %rax	# tmp297, __dif
.L142:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r15	# __dif, i
	jb	.L145	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cmpl	$-1, %r12d	#, r
	je	.L146	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _5
# /usr/include/c++/15/bits/chrono.h:720: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	subq	8(%rsp), %rax	# %sfp, _63
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp413
	vcvtsi2sdq	%rax, %xmm2, %xmm0	# _63, tmp413, tmp391
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_5].D.132534._M_impl.D.131869._M_finish, MEM[(const struct vector *)_5].D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vdivsd	.LC0(%rip), %xmm0, %xmm0	#, _59, _60
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	(%rdx), %rax	# MEM[(const struct vector *)_5].D.132534._M_impl.D.131869._M_start, _55
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp329
	imulq	%rbx, %rax	# tmp297, __dif_56
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	%r13, 16(%rsp)	# __new_finish, %sfp
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	vcvtsi2sdq	%rax, %xmm2, %xmm1	# __dif_56, tmp414, tmp392
	vdivsd	%xmm1, %xmm0, %xmm0	# _6, _60, _7
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	je	.L147	#,
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, 0(%r13)	# _7, *samples$_M_finish_22
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$8, %r13	#, __new_finish
.L146:
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movq	(%r14), %rax	# __closure_18(D)->__reps, __closure_18(D)->__reps
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	addl	$1, %r12d	#, r
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	cmpl	%r12d, (%rax)	# r, *_8
	jg	.L128	#,
.L141:
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	subq	24(%rsp), %r13	# %sfp, __new_finish
	movq	%r13, %r12	# __new_finish, _125
	je	.L127	#,
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%r13, %rdi	# _125,
	movq	%r13, %r14	# _125, _82
.LEHB0:
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/stl_uninitialized.h:273: 	      __builtin_memcpy(std::__niter_base(__result),
	movq	24(%rsp), %rsi	# %sfp,
	movq	%r12, %rdx	# _125,
	movq	%rax, %rdi	# _80,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rbp	# _125, _171
	sarq	$3, %rbp	#, _171
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r15	# _80, _80
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	(%rax,%r13), %r13	#, _109
# /usr/include/c++/15/bits/stl_uninitialized.h:273: 	      __builtin_memcpy(std::__niter_base(__result),
	call	memcpy@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	movl	$63, %edx	#, tmp357
	lzcntq	%rbp, %rax	# _171, tmp355
	subl	%eax, %edx	# tmp355, _174
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	movslq	%edx, %rdx	# _174, _175
# /usr/include/c++/15/bits/stl_algo.h:1906: 	  std::__introsort_loop(__first, __last,
	addq	%rdx, %rdx	# _175, _176
	movq	%r13, %rsi	# _109,
	movq	%r15, %rdi	# _80,
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0	#
# /usr/include/c++/15/bits/stl_algo.h:1816:       if (__last - __first > int(_S_threshold))
	addq	$-128, %r12	#, _125
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	movq	%rbp, %rbx	# _171, _70
# /usr/include/c++/15/bits/stl_algo.h:1816:       if (__last - __first > int(_S_threshold))
	jg	.L203	#,
# /usr/include/c++/15/bits/stl_algo.h:1823: 	std::__insertion_sort(__first, __last, __comp);
	movq	%r13, %rsi	# _109,
	movq	%r15, %rdi	# _80,
	vzeroupper
	call	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0	#
.L159:
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	testb	$1, %bpl	#, _171
	je	.L153	#,
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	%rbp, %r8	# _171, _171
	shrq	%r8	# _171
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	(%r15,%r8,8), %rbx	# *_155, <retval>
.L160:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r14, %rsi	# _82,
	movq	%r15, %rdi	# _80,
	call	_ZdlPvm@PLT	#
.L161:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	testq	%rdi, %rdi	# samples$_M_start
	je	.L126	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L126:
# lab5.cpp:137:     };
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	vmovq	%rbx, %xmm0	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L203:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_algo.h:1818: 	  std::__insertion_sort(__first, __first + int(_S_threshold), __comp);
	leaq	128(%r15), %rsi	#,
	movq	%r15, %rdi	# _80,
	vzeroupper
	call	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0	#
	leaq	128(%r15), %rcx	#, ivtmp.737
	.p2align 4,,10
	.p2align 3
.L158:
# /usr/include/c++/15/bits/stl_algo.h:1755: 	__val = _GLIBCXX_MOVE(*__last);
	vmovsd	(%rcx), %xmm1	# MEM[(type &)__i$_M_current_133], _182
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	vmovsd	-8(%rcx), %xmm0	# MEM[(double &)__i$_M_current_133 + 18446744073709551608], _145
	movq	%rcx, %rdx	# ivtmp.737, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	vcomisd	%xmm1, %xmm0	# _182, _145
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	leaq	-8(%rcx), %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	jbe	.L155	#,
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L157:
# /usr/include/c++/15/bits/stl_algo.h:1760: 	  *__last = _GLIBCXX_MOVE(*__next);
	vmovsd	%xmm0, 8(%rax)	# _145, MEM[(double &)__next$_M_current_96 + 8]
	movq	%rax, %rdx	# __next$_M_current, __i$_M_current
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	vmovsd	-8(%rax), %xmm0	# MEM[(double &)_187], _145
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	vcomisd	%xmm1, %xmm0	# _182, _145
	ja	.L157	#,
.L155:
# /usr/include/c++/15/bits/stl_algo.h:1798:       for (_RandomAccessIterator __i = __first; __i != __last; ++__i)
	addq	$8, %rcx	#, ivtmp.737
	cmpq	%r13, %rcx	# _109, ivtmp.737
# /usr/include/c++/15/bits/stl_algo.h:1764:       *__last = _GLIBCXX_MOVE(__val);
	vmovsd	%xmm1, (%rdx)	# _182, *__last$_M_current_95
# /usr/include/c++/15/bits/stl_algo.h:1798:       for (_RandomAccessIterator __i = __first; __i != __last; ++__i)
	jne	.L158	#,
	jmp	.L159	#
.L165:
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	xorl	%eax, %eax	#
	movq	%rax, 24(%rsp)	#, %sfp
	movq	%rax, 16(%rsp)	#, %sfp
.L127:
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	xorl	%r14d, %r14d	# _82
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%r15d, %r15d	# _80
# /usr/include/c++/15/bits/stl_vector.h:1122: 	return size_type(__dif);
	xorl	%ebx, %ebx	# _70
.L153:
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	%rbx, %rax	# _70, _157
	shrq	%rax	# _157
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	vmovsd	-8(%r15,%rax,8), %xmm0	# *_160, *_160
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	testq	%r15, %r15	# _80
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	vaddsd	(%r15,%rbx,4), %xmm0, %xmm0	# *_163, *_160, _165
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	vmulsd	.LC2(%rip), %xmm0, %xmm4	#, _165, <retval>
	vmovq	%xmm4, %rbx	# <retval>, <retval>
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	je	.L161	#,
	jmp	.L160	#
.L147:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	16(%rsp), %r13	# %sfp, _99
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$1152921504606846975, %rax	#, tmp334
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	24(%rsp), %r13	# %sfp, _99
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%r13, %rdx	# _99, __dif_100
	sarq	$3, %rdx	#, __dif_100
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	cmpq	%rax, %rdx	# tmp334, __dif_100
	je	.L134	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_100
	movl	$1, %eax	#, tmp393
	cmovne	%rdx, %rax	# __dif_100,, _102
	vmovsd	%xmm0, 8(%rsp)	# _7, %sfp
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_100, __len_103
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$1152921504606846975, %rdx	#, tmp394
	cmpq	%rdx, %rax	# tmp394, __len_103
	cmova	%rdx, %rax	# __len_103,, tmp394, __len_103
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	0(,%rax,8), %r15	#, _120
	movq	%r15, %rdi	# _120,
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	8(%rsp), %xmm0	# %sfp, _7
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	testq	%r13, %r13	# _99
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r8	#, _121
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, (%rax,%r13)	# _7, *_108
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	je	.L150	#,
# /usr/include/c++/15/bits/stl_uninitialized.h:1343: 	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rsi	# %sfp,
	movq	%r13, %rdx	# _99,
	movq	%rax, %rdi	# _121,
	call	memcpy@PLT	#
	movq	%rax, %r8	#, _121
.L150:
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	movq	24(%rsp), %rax	# %sfp, samples$_M_start
# /usr/include/c++/15/bits/vector.tcc:601: 	    ++__new_finish;
	leaq	8(%r8,%r13), %r13	#, __new_finish
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%rax, %rax	# samples$_M_start
	je	.L151	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rdi	# samples$_M_start,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%rax, %rsi	# samples$_M_start, samples$_M_end_of_storage
	movq	%r8, 8(%rsp)	# _121, %sfp
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	movq	8(%rsp), %r8	# %sfp, _121
.L151:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	leaq	(%r8,%r15), %rax	#, samples$_M_end_of_storage
	movq	%rax, 16(%rsp)	# samples$_M_end_of_storage, %sfp
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r8, 24(%rsp)	# _121, %sfp
# /usr/include/c++/15/bits/vector.tcc:647:     }
	jmp	.L146	#
.L202:
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movl	$-1, %ebp	#, r
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rbx	#, tmp253
	.p2align 4,,10
	.p2align 3
.L140:
# lab5.cpp:129:             const auto start = Clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _286
# lab5.cpp:129:             const auto start = Clock::now();
	movq	%rax, %r12	#, start
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_286].D.132534._M_impl.D.131869._M_finish, MEM[(const struct vector *)_286].D.132534._M_impl.D.131869._M_finish
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r15d, %r15d	# i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	(%rdx), %rax	# MEM[(const struct vector *)_286].D.132534._M_impl.D.131869._M_start, _283
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp251
	imulq	%rbx, %rax	# tmp253, __dif
	jmp	.L130	#
	.p2align 4,,10
	.p2align 3
.L204:
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	24(%r14), %rax	# __closure_18(D)->__edges, __closure_18(D)->__edges
	leaq	(%r15,%r15,2), %rdi	#, _69
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rsi	# _255->D.132534._M_impl.D.131869._M_start, _253
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
	salq	$5, %rdi	#, tmp257
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%rdi, %rsi	# tmp257, _253
	addq	(%rax), %rdi	# _252->D.132534._M_impl.D.131869._M_start, _250
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	call	_ZL5sobelRKN2cv3MatERS0_	#
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _271
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r15	#, i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_271].D.132534._M_impl.D.131869._M_finish, MEM[(const struct vector *)_271].D.132534._M_impl.D.131869._M_finish
	subq	(%rdx), %rax	# MEM[(const struct vector *)_271].D.132534._M_impl.D.131869._M_start, _268
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp266
	imulq	%rbx, %rax	# tmp253, __dif
.L130:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r15	# __dif, i
	jb	.L204	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cmpl	$-1, %ebp	#, r
	je	.L131	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _234
# /usr/include/c++/15/bits/chrono.h:720: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	subq	%r12, %rax	# start, _237
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp399
	vcvtsi2sdq	%rax, %xmm3, %xmm0	# _237, tmp399, tmp389
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_234].D.132534._M_impl.D.131869._M_finish, MEM[(const struct vector *)_234].D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	vdivsd	.LC0(%rip), %xmm0, %xmm0	#, _236, _235
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	(%rdx), %rax	# MEM[(const struct vector *)_234].D.132534._M_impl.D.131869._M_start, _221
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp276
	imulq	%rbx, %rax	# tmp253, __dif_220
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	%r13, 16(%rsp)	# __new_finish, %sfp
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	vcvtsi2sdq	%rax, %xmm3, %xmm1	# __dif_220, tmp400, tmp390
	vdivsd	%xmm1, %xmm0, %xmm0	# _213, _235, _208
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	je	.L205	#,
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, 0(%r13)	# _208, *samples$_M_finish_289
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$8, %r13	#, __new_finish
.L131:
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movq	(%r14), %rax	# __closure_18(D)->__reps, __closure_18(D)->__reps
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	addl	$1, %ebp	#, r
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	cmpl	%ebp, (%rax)	# r, *_92
	jg	.L140	#,
	jmp	.L141	#
.L205:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	16(%rsp), %r13	# %sfp, _192
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$1152921504606846975, %rdx	#, tmp281
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	24(%rsp), %r13	# %sfp, _192
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%r13, %rax	# _192, __dif_186
	sarq	$3, %rax	#, __dif_186
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	cmpq	%rdx, %rax	# tmp281, __dif_186
	je	.L134	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rax, %rax	# __dif_186
	movl	$1, %r12d	#, tmp395
	cmovne	%rax, %r12	# __dif_186,, _177
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	vmovsd	%xmm0, 8(%rsp)	# _208, %sfp
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %r12	# __dif_186, __len_170
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %r12	# tmp281, __len_170
	cmova	%rdx, %r12	# __len_170,, tmp281, __len_170
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	salq	$3, %r12	#, _168
	movq	%r12, %rdi	# _168,
	call	_Znwm@PLT	#
.LEHE0:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	8(%rsp), %xmm0	# %sfp, _208
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	testq	%r13, %r13	# _192
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r15	#, _149
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, (%rax,%r13)	# _208, *_143
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	jne	.L135	#,
.L139:
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	cmpq	$0, 24(%rsp)	#, %sfp
# /usr/include/c++/15/bits/vector.tcc:601: 	    ++__new_finish;
	leaq	8(%r15,%r13), %r13	#, __new_finish
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	je	.L138	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L138:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	leaq	(%r15,%r12), %rax	#, samples$_M_end_of_storage
	movq	%rax, 16(%rsp)	# samples$_M_end_of_storage, %sfp
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r15, 24(%rsp)	# _149, %sfp
	jmp	.L131	#
.L135:
# /usr/include/c++/15/bits/stl_uninitialized.h:1343: 	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rsi	# %sfp,
	movq	%r13, %rdx	# _192,
	movq	%rax, %rdi	# _149,
	call	memcpy@PLT	#
	jmp	.L139	#
.L198:
	endbr64	
	jmp	.L199	#
	.section	.gcc_except_table,"a",@progbits
.LLSDA17250:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE17250-.LLSDACSB17250
.LLSDACSB17250:
	.uleb128 .LEHB0-.LFB17250
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L198-.LFB17250
	.uleb128 0
.LLSDACSE17250:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC17250
	.type	_ZZ4mainENKUliE_clEi.cold, @function
_ZZ4mainENKUliE_clEi.cold:
.LFSB17250:
.L134:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/15/bits/stl_vector.h:2205: 	  __throw_length_error(__N(__s));
	leaq	.LC1(%rip), %rdi	#,
.LEHB1:
	call	_ZSt20__throw_length_errorPKc@PLT	#
.LEHE1:
.L167:
	endbr64	
.L199:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	cmpq	$0, 24(%rsp)	#, %sfp
	movq	%rax, %rbx	#, tmp387
	je	.L200	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	vzeroupper
	call	_ZdlPvm@PLT	#
.L164:
	movq	%rbx, %rdi	# tmp387,
.LEHB2:
	call	_Unwind_Resume@PLT	#
.LEHE2:
.L200:
	vzeroupper
	jmp	.L164	#
	.cfi_endproc
.LFE17250:
	.section	.gcc_except_table
.LLSDAC17250:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC17250-.LLSDACSBC17250
.LLSDACSBC17250:
	.uleb128 .LEHB1-.LCOLDB3
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L167-.LCOLDB3
	.uleb128 0
	.uleb128 .LEHB2-.LCOLDB3
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSEC17250:
	.section	.text.unlikely
	.text
	.size	_ZZ4mainENKUliE_clEi, .-_ZZ4mainENKUliE_clEi
	.section	.text.unlikely
	.size	_ZZ4mainENKUliE_clEi.cold, .-_ZZ4mainENKUliE_clEi.cold
.LCOLDE3:
	.text
.LHOTE3:
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EED2Ev,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev, @function
_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev:
.LFB18420:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12	# this, this
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/15/bits/stl_vector.h:802: 	std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	8(%rdi), %rbp	# this_3(D)->D.132534._M_impl.D.131869._M_finish, _1
# /usr/include/c++/15/bits/stl_vector.h:802: 	std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	(%rdi), %rbx	# this_3(D)->D.132534._M_impl.D.131869._M_start, __first
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _1
	je	.L207	#,
	.p2align 4,,10
	.p2align 3
.L208:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _1
	jne	.L208	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%r12), %rbx	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_start, __first
.L207:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	testq	%rbx, %rbx	# __first
	je	.L211	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%r12), %rsi	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_end_of_storage, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rbx, %rsi	# __first, _10
# /usr/include/c++/15/bits/stl_vector.h:805:       }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4,,10
	.p2align 3
.L211:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_vector.h:805:       }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE18420:
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev, .-_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev
	.set	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev,_ZNSt6vectorIN2cv3MatESaIS1_EED2Ev
	.section	.rodata._ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_.str1.8,"aMS",@progbits,1
	.align 8
.LC4:
	.string	"cannot create std::vector larger than max_size()"
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EEC5EmRKS2_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_, @function
_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_:
.LFB18434:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
# /usr/include/c++/15/bits/stl_vector.h:2215: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	movabsq	$96076792050570581, %rax	#, tmp110
# /usr/include/c++/15/bits/stl_vector.h:586:       vector(size_type __n, const allocator_type& __a = allocator_type())
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/15/bits/stl_vector.h:2215: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	cmpq	%rsi, %rax	# __n, tmp110
	jb	.L220	#,
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%rsi, %rsi	# __n
	movq	%rdi, %r12	# this, this
	movq	%rsi, %rbx	# __n, __n
	je	.L221	#,
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rsi,%rsi,2), %r13	#, _29
	salq	$5, %r13	#, tmp115
	movq	%r13, %rdi	# tmp115,
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	addq	%rax, %r13	# _30, _1
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	vmovq	%rax, %xmm1	# _30, _30
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%r13, 16(%r12)	# _1, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	vpunpcklqdq	%xmm1, %xmm1, %xmm0	# _30, _33
	vmovdqu	%xmm0, (%r12)	# _33, MEM <vector(2) long unsigned int> [(struct Mat * *)this_3(D)]
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rax, %rbp	# _30, __first
	.p2align 4,,10
	.p2align 3
.L217:
# /usr/include/c++/15/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movq	%rbp, %rdi	# __first,
	call	_ZN2cv3MatC1Ev@PLT	#
# /usr/include/c++/15/bits/stl_uninitialized.h:875: 	  for (; __n > 0; --__n, (void) ++__first)
	addq	$96, %rbp	#, __first
# /usr/include/c++/15/bits/stl_uninitialized.h:875: 	  for (; __n > 0; --__n, (void) ++__first)
	subq	$1, %rbx	#, __n
	jne	.L217	#,
	movq	%r13, %rax	# _1, _1
# /usr/include/c++/15/bits/stl_vector.h:2010: 	this->_M_impl._M_finish =
	movq	%rax, 8(%r12)	# _1, *this_3(D).D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/stl_vector.h:588:       { _M_default_initialize(__n); }
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L221:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%eax, %eax	# _1
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	movq	$0, (%rdi)	#, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_start
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	$0, 16(%rdi)	#, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.131869._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:2010: 	this->_M_impl._M_finish =
	movq	%rax, 8(%r12)	# _1, *this_3(D).D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/stl_vector.h:588:       { _M_default_initialize(__n); }
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
.L220:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_vector.h:2216: 	  __throw_length_error(
	leaq	.LC4(%rip), %rdi	#,
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE18434:
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_, .-_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_
	.set	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_,_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_, @function
_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_:
.LFB19333:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA19333
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp128
# /usr/include/c++/15/bits/vector.tcc:557:       vector<_Tp, _Alloc>::
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_9(D)].D.132534._M_impl.D.131869._M_finish, _15
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rdi), %r13	# MEM[(const struct vector *)this_9(D)].D.132534._M_impl.D.131869._M_start, _16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbp, %rbx	# _15, _17
	subq	%r13, %rbx	# _16, _17
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbx, %rdx	# _17, tmp126
	sarq	$5, %rdx	#, tmp126
	imulq	%rax, %rdx	# tmp128, __dif_18
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$96076792050570581, %rax	#, tmp129
	cmpq	%rax, %rdx	# tmp129, __dif_18
	je	.L245	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_18
	movl	$1, %eax	#, tmp153
	cmovne	%rdx, %rax	# __dif_18,, _20
	movq	%rdi, %r14	# this, this
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_18, __len_21
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$96076792050570581, %rdx	#, tmp154
	cmpq	%rdx, %rax	# tmp154, __len_21
	cmova	%rdx, %rax	# __len_21,, tmp154, __len_21
	movq	%rsi, (%rsp)	# __args#0, %sfp
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rax,%rax,2), %r15	#, _47
	salq	$5, %r15	#, _47
	movq	%r15, %rdi	# _47, tmp136
	movq	%r15, 16(%rsp)	# tmp136, %sfp
.LEHB3:
	call	_Znwm@PLT	#
.LEHE3:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	(%rsp), %rsi	# %sfp, __args#0
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	leaq	(%rax,%rbx), %rdi	#, _2
	movq	%rdi, 24(%rsp)	# _2, %sfp
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	#, _48
.LEHB4:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE4:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r13, %rbp	# _16, _15
	je	.L224	#,
	movq	%r12, %rbx	# _48, __result
	movq	%r13, %r15	# _16, __first
	jmp	.L228	#
	.p2align 4,,10
	.p2align 3
.L234:
	addq	$96, %rbx	#, __result
.L228:
# /usr/include/c++/15/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movq	%r15, %rsi	# __first,
	movq	%rbx, %rdi	# __result,
.LEHB5:
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE5:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	addq	$96, %r15	#, __first
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r15, %rbp	# __first, _15
	jne	.L234	#,
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	192(%rbx), %r15	#, __new_finish
	movq	%r13, %rbx	# _16, __first
	.p2align 4,,10
	.p2align 3
.L229:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _15
	jne	.L229	#,
.L233:
	vmovq	%r12, %xmm1	# _48, _48
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%r13, %r13	# _16
	vpinsrq	$1, %r15, %xmm1, %xmm0	# __new_finish, _48, _5
	je	.L232	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%r14), %rsi	# this_9(D)->D.132534._M_impl.D.131869._M_end_of_storage, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _16,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%r13, %rsi	# _16, _4
	vmovdqa	%xmm0, (%rsp)	# _5, %sfp
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	vmovdqa	(%rsp), %xmm0	# %sfp, _5
.L232:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	16(%rsp), %r12	# %sfp, tmp147
	movq	%r12, 16(%r14)	# tmp147, this_9(D)->D.132534._M_impl.D.131869._M_end_of_storage
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%r14)	# _5, MEM <vector(2) long unsigned int> [(struct Mat * *)this_9(D)]
# /usr/include/c++/15/bits/vector.tcc:647:     }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L224:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	96(%r12), %r15	#, __new_finish
	jmp	.L233	#
.L236:
	endbr64	
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%rax, %rbp	#, tmp151
	jmp	.L226	#
.L235:
	endbr64	
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rbp	# tmp152, tmp142
	jmp	.L231	#
.L245:
# /usr/include/c++/15/bits/stl_vector.h:2205: 	  __throw_length_error(__N(__s));
	leaq	.LC1(%rip), %rdi	#,
.LEHB6:
	call	_ZSt20__throw_length_errorPKc@PLT	#
.L226:
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%r12, %r13	# _48, __first
	vzeroupper
.L227:
	cmpq	%rbx, %r13	# __result, __first
	je	.L246	#,
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%r13, %rdi	# __first,
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %r13	#, __first
	jmp	.L227	#
.L246:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZN2cv3MatD1Ev@PLT	#
.L231:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	16(%rsp), %rsi	# %sfp,
	movq	%r12, %rdi	# _48,
	vzeroupper
	call	_ZdlPvm@PLT	#
	movq	%rbp, %rdi	# tmp142,
	call	_Unwind_Resume@PLT	#
.LEHE6:
	.cfi_endproc
.LFE19333:
	.section	.gcc_except_table
.LLSDA19333:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE19333-.LLSDACSB19333
.LLSDACSB19333:
	.uleb128 .LEHB3-.LFB19333
	.uleb128 .LEHE3-.LEHB3
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB4-.LFB19333
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L235-.LFB19333
	.uleb128 0
	.uleb128 .LEHB5-.LFB19333
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L236-.LFB19333
	.uleb128 0
	.uleb128 .LEHB6-.LFB19333
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE19333:
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,comdat
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_, .-_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_, @function
_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_:
.LFB20164:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA20164
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp128
# /usr/include/c++/15/bits/vector.tcc:557:       vector<_Tp, _Alloc>::
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_9(D)].D.132534._M_impl.D.131869._M_finish, _15
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rdi), %r13	# MEM[(const struct vector *)this_9(D)].D.132534._M_impl.D.131869._M_start, _16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbp, %rbx	# _15, _17
	subq	%r13, %rbx	# _16, _17
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbx, %rdx	# _17, tmp126
	sarq	$5, %rdx	#, tmp126
	imulq	%rax, %rdx	# tmp128, __dif_18
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$96076792050570581, %rax	#, tmp129
	cmpq	%rax, %rdx	# tmp129, __dif_18
	je	.L270	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_18
	movl	$1, %eax	#, tmp153
	cmovne	%rdx, %rax	# __dif_18,, _20
	movq	%rdi, %r14	# this, this
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_18, __len_21
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$96076792050570581, %rdx	#, tmp154
	cmpq	%rdx, %rax	# tmp154, __len_21
	cmova	%rdx, %rax	# __len_21,, tmp154, __len_21
	movq	%rsi, (%rsp)	# __args#0, %sfp
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rax,%rax,2), %r15	#, _47
	salq	$5, %r15	#, _47
	movq	%r15, %rdi	# _47, tmp136
	movq	%r15, 16(%rsp)	# tmp136, %sfp
.LEHB7:
	call	_Znwm@PLT	#
.LEHE7:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	(%rsp), %rsi	# %sfp, __args#0
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	leaq	(%rax,%rbx), %rdi	#, _2
	movq	%rdi, 24(%rsp)	# _2, %sfp
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	#, _48
.LEHB8:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1EOS0_@PLT	#
.LEHE8:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r13, %rbp	# _16, _15
	je	.L249	#,
	movq	%r12, %rbx	# _48, __result
	movq	%r13, %r15	# _16, __first
	jmp	.L253	#
	.p2align 4,,10
	.p2align 3
.L259:
	addq	$96, %rbx	#, __result
.L253:
# /usr/include/c++/15/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movq	%r15, %rsi	# __first,
	movq	%rbx, %rdi	# __result,
.LEHB9:
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE9:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	addq	$96, %r15	#, __first
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r15, %rbp	# __first, _15
	jne	.L259	#,
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	192(%rbx), %r15	#, __new_finish
	movq	%r13, %rbx	# _16, __first
	.p2align 4,,10
	.p2align 3
.L254:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _15
	jne	.L254	#,
.L258:
	vmovq	%r12, %xmm1	# _48, _48
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%r13, %r13	# _16
	vpinsrq	$1, %r15, %xmm1, %xmm0	# __new_finish, _48, _5
	je	.L257	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%r14), %rsi	# this_9(D)->D.132534._M_impl.D.131869._M_end_of_storage, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _16,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%r13, %rsi	# _16, _4
	vmovdqa	%xmm0, (%rsp)	# _5, %sfp
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	vmovdqa	(%rsp), %xmm0	# %sfp, _5
.L257:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	16(%rsp), %r12	# %sfp, tmp147
	movq	%r12, 16(%r14)	# tmp147, this_9(D)->D.132534._M_impl.D.131869._M_end_of_storage
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%r14)	# _5, MEM <vector(2) long unsigned int> [(struct Mat * *)this_9(D)]
# /usr/include/c++/15/bits/vector.tcc:647:     }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L249:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	96(%r12), %r15	#, __new_finish
	jmp	.L258	#
.L261:
	endbr64	
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%rax, %rbp	#, tmp151
	jmp	.L251	#
.L260:
	endbr64	
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rbp	# tmp152, tmp142
	jmp	.L256	#
.L270:
# /usr/include/c++/15/bits/stl_vector.h:2205: 	  __throw_length_error(__N(__s));
	leaq	.LC1(%rip), %rdi	#,
.LEHB10:
	call	_ZSt20__throw_length_errorPKc@PLT	#
.L251:
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%r12, %r13	# _48, __first
	vzeroupper
.L252:
	cmpq	%rbx, %r13	# __result, __first
	je	.L271	#,
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%r13, %rdi	# __first,
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %r13	#, __first
	jmp	.L252	#
.L271:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZN2cv3MatD1Ev@PLT	#
.L256:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	16(%rsp), %rsi	# %sfp,
	movq	%r12, %rdi	# _48,
	vzeroupper
	call	_ZdlPvm@PLT	#
	movq	%rbp, %rdi	# tmp142,
	call	_Unwind_Resume@PLT	#
.LEHE10:
	.cfi_endproc
.LFE20164:
	.section	.gcc_except_table
.LLSDA20164:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE20164-.LLSDACSB20164
.LLSDACSB20164:
	.uleb128 .LEHB7-.LFB20164
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LFB20164
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L260-.LFB20164
	.uleb128 0
	.uleb128 .LEHB9-.LFB20164
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L261-.LFB20164
	.uleb128 0
	.uleb128 .LEHB10-.LFB20164
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSE20164:
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,comdat
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_, .-_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	"basic_string: construction from null is not valid"
	.align 8
.LC6:
	.string	"Could not read video; using deterministic synthetic frames.\n"
	.align 8
.LC10:
	.string	"Source: current optimized implementation\n"
	.section	.rodata.str1.1
.LC11:
	.string	"Frames: "
.LC12:
	.string	" at "
.LC13:
	.string	"x"
.LC14:
	.string	"; median of "
.LC15:
	.string	" repetitions (ms/frame)\n"
.LC16:
	.string	"Grayscale: "
.LC17:
	.string	"\nSobel: "
.LC18:
	.string	"\nTotal: "
.LC19:
	.string	"\n"
	.section	.text.unlikely
.LCOLDB21:
	.section	.text.startup,"ax",@progbits
.LHOTB21:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB17249:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA17249
	endbr64	
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp	#,
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx	#
	subq	$480, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
# lab5.cpp:115: int main(int argc, char** argv) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp203
	movq	%rax, -56(%rbp)	# tmp203, D.411998
	xorl	%eax, %eax	# tmp203
# lab5.cpp:116:     const std::string video = argc > 1 ? argv[1] : "";
	cmpl	$1, %edi	#, argc
	jle	.L326	#,
# lab5.cpp:116:     const std::string video = argc > 1 ? argv[1] : "";
	movq	8(%rsi), %r15	# MEM[(char * *)argv_23(D) + 8B], iftmp.0_24
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	leaq	-288(%rbp), %rax	#, tmp390
	leaq	-272(%rbp), %rbx	#, _133
# /usr/include/c++/15/bits/basic_string.h:710: 	if (__s == 0)
	testq	%r15, %r15	# iftmp.0_24
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	movq	%rax, -504(%rbp)	# tmp390, %sfp
	movq	%rbx, -288(%rbp)	# _133, MEM[(struct _Alloc_hider *)&video]._M_p
	movq	%rsi, %r13	# argv, argv
# /usr/include/c++/15/bits/basic_string.h:710: 	if (__s == 0)
	je	.L322	#,
	movl	%edi, %r12d	# argc, argc
# /usr/include/c++/15/bits/char_traits.h:393: 	return __builtin_strlen(__s);
	movq	%r15, %rdi	# iftmp.0_24,
	call	strlen@PLT	#
# /usr/include/c++/15/bits/basic_string.tcc:233: 	if (__dnew > size_type(_S_local_capacity))
	cmpq	$15, %rax	#, tmp402
# /usr/include/c++/15/bits/basic_string.tcc:231: 	size_type __dnew = static_cast<size_type>(std::distance(__beg, __end));
	movq	%rax, -336(%rbp)	# tmp402, MEM[(long unsigned int *)_316]
# /usr/include/c++/15/bits/char_traits.h:393: 	return __builtin_strlen(__s);
	movq	%rax, %r14	#, tmp402
# /usr/include/c++/15/bits/basic_string.tcc:233: 	if (__dnew > size_type(_S_local_capacity))
	jbe	.L277	#,
# /usr/include/c++/15/bits/basic_string.tcc:235: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	-504(%rbp), %rdi	# %sfp,
	leaq	-336(%rbp), %rsi	#, tmp215
	xorl	%edx, %edx	#
.LEHB11:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT	#
.LEHE11:
# /usr/include/c++/15/bits/basic_string.h:229:       { _M_dataplus._M_p = __p; }
	movq	%rax, -288(%rbp)	# _133, video._M_dataplus._M_p
# /usr/include/c++/15/bits/basic_string.tcc:235: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	%rax, %rdi	# _133, _133
# /usr/include/c++/15/bits/basic_string.h:266:       { _M_allocated_capacity = __capacity; }
	movq	-336(%rbp), %rax	# MEM[(long unsigned int *)_316], MEM[(long unsigned int *)_316]
	movq	%rax, -272(%rbp)	# MEM[(long unsigned int *)_316], video.D.73061._M_allocated_capacity
.L278:
# /usr/include/c++/15/bits/char_traits.h:429: 	return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
	movq	%r14, %rdx	# tmp402,
	movq	%r15, %rsi	# iftmp.0_24,
	call	memcpy@PLT	#
.L280:
# /usr/include/c++/15/bits/basic_string.tcc:257: 	_M_set_length(__dnew);
	movq	-336(%rbp), %rax	# MEM[(long unsigned int *)_316], __dnew.6_142
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movq	-288(%rbp), %rdx	# video._M_dataplus._M_p, video._M_dataplus._M_p
# lab5.cpp:117:     const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
	cmpl	$2, %r12d	#, argc
# /usr/include/c++/15/bits/basic_string.h:234:       { _M_string_length = __length; }
	movq	%rax, -280(%rbp)	# __dnew.6_142, video._M_string_length
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	$0, (%rdx,%rax)	#, MEM[(char_type &)_144]
# lab5.cpp:117:     const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
	je	.L274	#,
# /usr/include/stdlib.h:487:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	16(%r13), %rdi	# MEM[(char * *)argv_23(D) + 16B], MEM[(char * *)argv_23(D) + 16B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testl	%eax, %eax	# _76
	movl	$1, %edx	#, tmp425
	cmovg	%eax, %edx	# _76,, tmp425
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	cmpl	$3, %r12d	#, argc
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	movl	%edx, -472(%rbp)	# tmp425, %sfp
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	$7, %eax	#, iftmp.1_14
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	jne	.L327	#,
.L282:
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	%xmm0, %xmm0, %xmm0	# tmp226
# lab5.cpp:98:     if (!path.empty()) {
	cmpq	$0, -280(%rbp)	#, video._M_string_length
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	%eax, -460(%rbp)	# iftmp.1_14, reps
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, -416(%rbp)	#, MEM[(struct _Vector_impl_data *)&color]._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqa	%xmm0, -432(%rbp)	# tmp226, MEM <vector(2) long unsigned int> [(struct Mat * *)&color]
# lab5.cpp:98:     if (!path.empty()) {
	jne	.L283	#,
	leaq	-432(%rbp), %rax	#, tmp393
	movq	%rax, -480(%rbp)	# tmp393, %sfp
.L292:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	leaq	-440(%rbp), %rax	#, tmp396
	movq	%rax, -488(%rbp)	# tmp396, %sfp
	leaq	-448(%rbp), %rax	#, tmp398
# /usr/include/opencv4/opencv2/core/operations.hpp:395: inline RNG::RNG(uint64 _state) { state = _state ? _state : 0xffffffff; }
	movq	$442, -456(%rbp)	#, rng.state
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, -496(%rbp)	# tmp398, %sfp
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	.LC8(%rip), %r15	#, tmp397
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	xorl	%r14d, %r14d	# i
	leaq	-160(%rbp), %rbx	#, tmp388
	jmp	.L284	#
	.p2align 4,,10
	.p2align 3
.L329:
.LEHB12:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE12:
# /usr/include/c++/15/bits/stl_vector.h:1423: 	    ++this->_M_impl._M_finish;
	addq	$96, -424(%rbp)	#, color.D.132534._M_impl.D.131869._M_finish
.L295:
# lab5.cpp:110:         }
	movq	%rbx, %rdi	# tmp388,
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	addl	$1, %r14d	#, i
# lab5.cpp:110:         }
	call	_ZN2cv3MatD1Ev@PLT	#
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	cmpl	%r14d, -472(%rbp)	# i, %sfp
	je	.L328	#,
.L284:
# lab5.cpp:107:             cv::Mat frame(720, 1280, CV_8UC3);
	movl	$16, %ecx	#,
	movl	$1280, %edx	#,
	movl	$720, %esi	#,
	movq	%rbx, %rdi	# tmp388,
.LEHB13:
	call	_ZN2cv3MatC1Eiii@PLT	#
.LEHE13:
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	.LC7(%rip), %rax	#, tmp442
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	leaq	-336(%rbp), %r12	#, tmp389
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	%rax, -440(%rbp)	# tmp442, D.411895
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	-488(%rbp), %rax	# %sfp, tmp396
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	leaq	-400(%rbp), %r13	#, tmp386
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, -328(%rbp)	# tmp396, MEM[(struct _InputArray *)_316].obj
	movq	-496(%rbp), %rax	# %sfp, tmp398
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	leaq	-368(%rbp), %rcx	#, tmp262
	leaq	-456(%rbp), %rdi	#, tmp264
	xorl	%r9d, %r9d	#
	movq	%r12, %r8	# tmp389,
	xorl	%edx, %edx	#
	movq	%r13, %rsi	# tmp386,
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movl	$-1056833530, -336(%rbp)	#, MEM[(struct _InputArray *)_316].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%r15, -320(%rbp)	# tmp397, MEM <vector(2) int> [(struct _InputArray *)_316 + 16B]
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	$0x000000000, -448(%rbp)	#, D.411893
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movl	$-1056833530, -368(%rbp)	#, MEM[(struct _InputArray *)_202].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, -360(%rbp)	# tmp398, MEM[(struct _InputArray *)_202].obj
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%r15, -352(%rbp)	# tmp397, MEM <vector(2) int> [(struct _InputArray *)_202 + 16B]
# /usr/include/opencv4/opencv2/core/types.hpp:1686:     : width(0), height(0) {}
	movq	$0, -384(%rbp)	#, MEM <vector(2) int> [(int *)_203 + 16B]
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movl	$50397184, -400(%rbp)	#, MEM[(struct _InputArray *)_203].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movq	%rbx, -392(%rbp)	# tmp388, MEM[(struct _InputArray *)_203].obj
.LEHB14:
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	call	_ZN2cv3RNG4fillERKNS_17_InputOutputArrayEiRKNS_11_InputArrayES6_b@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1418: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	-424(%rbp), %rdi	# color.D.132534._M_impl.D.131869._M_finish, _174
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	%rbx, %rsi	# tmp388,
# /usr/include/c++/15/bits/stl_vector.h:1418: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	-416(%rbp), %rdi	# color.D.132534._M_impl.D.131869._M_end_of_storage, _174
	jne	.L329	#,
# /usr/include/c++/15/bits/stl_vector.h:1427: 	  _M_realloc_append(__x);
	movq	-480(%rbp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_	#
.LEHE14:
	jmp	.L295	#
.L277:
# /usr/include/c++/15/bits/basic_string.h:450: 	if (__n == 1)
	cmpq	$1, %rax	#, tmp402
	jne	.L279	#,
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movzbl	(%r15), %eax	# MEM[(const char_type &)iftmp.0_24], _141
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	%al, -272(%rbp)	# _141, MEM[(char_type &)&video + 16]
# /usr/include/c++/15/bits/char_traits.h:353:       }
	jmp	.L280	#
.L326:
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	leaq	-272(%rbp), %rax	#, tmp206
	movq	%rax, -288(%rbp)	# tmp206, MEM[(struct _Alloc_hider *)&video]._M_p
# /usr/include/c++/15/bits/basic_string.h:234:       { _M_string_length = __length; }
	xorl	%eax, %eax	#
	movq	%rax, -336(%rbp)	#, MEM[(long unsigned int *)_316]
	movq	%rax, -280(%rbp)	#, video._M_string_length
	leaq	-288(%rbp), %rax	#, tmp390
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	$0, -272(%rbp)	#, MEM[(char_type &)_197]
	movq	%rax, -504(%rbp)	# tmp390, %sfp
.L274:
# lab5.cpp:117:     const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
	movl	$30, -472(%rbp)	#, %sfp
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	$7, %eax	#, iftmp.1_14
	jmp	.L282	#
.L283:
# lab5.cpp:99:         cv::VideoCapture video(path);
	leaq	-336(%rbp), %r12	#, tmp389
	movq	-504(%rbp), %rsi	# %sfp,
	leaq	-432(%rbp), %rax	#, tmp393
	xorl	%edx, %edx	#
	movq	%r12, %rdi	# tmp389,
	movq	%rax, -480(%rbp)	# tmp393, %sfp
.LEHB15:
	call	_ZN2cv12VideoCaptureC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi@PLT	#
.LEHE15:
# lab5.cpp:100:         cv::Mat frame;
	leaq	-256(%rbp), %r13	#, tmp392
	movq	%r13, %rdi	# tmp392,
	call	_ZN2cv3MatC1Ev@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rdx	# color.D.132534._M_impl.D.131869._M_finish, _147
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-432(%rbp), %rcx	# color.D.132534._M_impl.D.131869._M_start, _148
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rdx, %rax	# _147, _13
	subq	%rcx, %rax	# _148, _13
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp231
	movabsq	$-6148914691236517205, %r14	#, tmp233
	leaq	-432(%rbp), %rbx	#, tmp393
	imulq	%r14, %rax	# tmp233, __dif
	movq	%rbx, -480(%rbp)	# tmp393, %sfp
	jmp	.L285	#
	.p2align 4,,10
	.p2align 3
.L331:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	leaq	-368(%rbp), %rsi	#, tmp246
	movq	%r12, %rdi	# tmp389,
# /usr/include/opencv4/opencv2/core/types.hpp:1686:     : width(0), height(0) {}
	movq	$0, -352(%rbp)	#, MEM <vector(2) int> [(int *)_202 + 16B]
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movl	$33619968, -368(%rbp)	#, MEM[(struct _InputArray *)_202].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movq	%r13, -360(%rbp)	# tmp392, MEM[(struct _InputArray *)_202].obj
.LEHB16:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	call	_ZN2cv12VideoCapture4readERKNS_12_OutputArrayE@PLT	#
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	testb	%al, %al	# _152
	je	.L330	#,
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	leaq	-160(%rbp), %rbx	#, tmp388
	movq	%r13, %rsi	# tmp392,
	movq	%rbx, %rdi	# tmp388,
	call	_ZNK2cv3Mat5cloneEv@PLT	#
.LEHE16:
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	-424(%rbp), %rdi	# color.D.132534._M_impl.D.131869._M_finish, _160
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	%rbx, %rsi	# tmp388,
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	-416(%rbp), %rdi	# color.D.132534._M_impl.D.131869._M_end_of_storage, _160
	je	.L286	#,
.LEHB17:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1EOS0_@PLT	#
.LEHE17:
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$96, -424(%rbp)	#, color.D.132534._M_impl.D.131869._M_finish
.L287:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	movq	%rbx, %rdi	# tmp388,
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rdx	# color.D.132534._M_impl.D.131869._M_finish, _147
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-432(%rbp), %rcx	# color.D.132534._M_impl.D.131869._M_start, _148
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rdx, %rax	# _147, _149
	subq	%rcx, %rax	# _148, _149
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp241
	imulq	%r14, %rax	# tmp233, __dif
.L285:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	cmpl	%eax, -472(%rbp)	# __dif, %sfp
	jg	.L331	#,
.L289:
# lab5.cpp:102:         if (frames.empty()) std::cerr << "Could not read video; using deterministic synthetic frames.\n";
	cmpq	%rdx, %rcx	# _147, _148
	je	.L332	#,
.L291:
# lab5.cpp:103:     }
	movq	%r13, %rdi	# tmp392,
	call	_ZN2cv3MatD1Ev@PLT	#
# lab5.cpp:103:     }
	movq	%r12, %rdi	# tmp389,
	call	_ZN2cv12VideoCaptureD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_iterator.h:1059:       : _M_current(__i) { }
	movq	-424(%rbp), %rsi	# MEM[(const struct Mat * const &)&color + 8], _156
	movq	-432(%rbp), %rax	# MEM[(const struct Mat * const &)&color], _157
# lab5.cpp:104:     if (frames.empty()) {
	cmpq	%rax, %rsi	# _157, _156
	je	.L292	#,
	leaq	-400(%rbp), %r13	#, tmp386
.L293:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rax, %rsi	# _157, _69
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rsi	#, tmp272
	movabsq	$-6148914691236517205, %rax	#, tmp274
	imulq	%rax, %rsi	# tmp274, __dif_39
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	movq	%r12, %rdx	# tmp389,
	movq	%r13, %rdi	# tmp386,
.LEHB18:
	call	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_	#
.LEHE18:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rsi	# color.D.132534._M_impl.D.131869._M_finish, color.D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp299
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	-432(%rbp), %rsi	# color.D.132534._M_impl.D.131869._M_start, _32
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rsi	#, tmp297
	imulq	%rax, %rsi	# tmp299, __dif_31
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	leaq	-368(%rbp), %rax	#, tmp387
	movq	%r12, %rdx	# tmp389,
	movq	%rax, %rdi	# tmp387,
	movq	%rax, -472(%rbp)	# tmp387, %sfp
.LEHB19:
	call	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_	#
.LEHE19:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-432(%rbp), %rdx	# color.D.132534._M_impl.D.131869._M_start, _92
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_finish, _190
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rbx	#, tmp305
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rdx, %rax	# _92, _190
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp303
	imulq	%rbx, %rax	# tmp305, __dif
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r14d, %r14d	# i
	jmp	.L302	#
	.p2align 4,,10
	.p2align 3
.L303:
	leaq	(%r14,%r14,2), %r15	#, _44
	salq	$5, %r15	#, tmp309
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rdx	# tmp309, _83
# lab5.cpp:122:         gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
	movl	12(%rdx), %eax	# _83->cols, _83->cols
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	-400(%rbp), %rdi	# MEM[(struct vector *)_203].D.132534._M_impl.D.131869._M_start, _86
# lab5.cpp:122:         gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
	movl	8(%rdx), %esi	# _83->rows, _83->rows
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rdi	# tmp309, _86
# lab5.cpp:122:         gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
	xorl	%ecx, %ecx	#
	movl	%eax, %edx	# _83->cols,
.LEHB20:
	call	_ZN2cv3Mat6createEiii@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	-432(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_start, _88
	movq	-368(%rbp), %rdi	# MEM[(struct vector *)_202].D.132534._M_impl.D.131869._M_start, tmp309
	addq	%r15, %rax	# tmp309, _88
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	movl	12(%rax), %ecx	# _88->cols, tmp450
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	movl	8(%rax), %esi	# _88->rows, _88->rows
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	leal	-2(%rcx), %edx	#, _6
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	subl	$2, %esi	#, _8
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rdi	# tmp309, tmp309
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	xorl	%ecx, %ecx	#
	call	_ZN2cv3Mat6createEiii@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-432(%rbp), %rdx	# color.D.132534._M_impl.D.131869._M_start, _92
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_finish, _93
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r14	#, i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rdx, %rax	# _92, _93
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp323
	imulq	%rbx, %rax	# tmp305, __dif
.L302:
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r14	# __dif, i
	jb	.L303	#,
# lab5.cpp:137:     };
	movq	-480(%rbp), %r14	# %sfp, tmp393
	leaq	-460(%rbp), %rax	#, _322
	vmovq	%r13, %xmm2	# tmp386, tmp386
	vpinsrq	$1, -472(%rbp), %xmm2, %xmm1	# %sfp, tmp386, tmp331
	vmovq	%rax, %xmm0	# _322, _322
	vpinsrq	$1, %r14, %xmm0, %xmm0	# tmp393, _322, tmp332
	vinserti128	$0x1, %xmm1, %ymm0, %ymm0	# tmp331, tmp332, _323
	vmovdqa	%ymm0, -336(%rbp)	# _323, MEM <vector(4) long unsigned int> [(void *)_316]
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	xorl	%esi, %esi	#
	movq	%r12, %rdi	# tmp389,
	vzeroupper
	call	_ZZ4mainENKUliE_clEi	#
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movl	$1, %esi	#,
	movq	%r12, %rdi	# tmp389,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	vmovq	%xmm0, %r15	#, _46
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	call	_ZZ4mainENKUliE_clEi	#
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movl	$2, %esi	#,
	movq	%r12, %rdi	# tmp389,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	vmovsd	%xmm0, -488(%rbp)	#, %sfp
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	call	_ZZ4mainENKUliE_clEi	#
# /usr/include/c++/15/bits/ostream.h:140: 	__pf(*this);
	movq	_ZSt4cout(%rip), %rax	# cout._vptr.basic_ostream, cout._vptr.basic_ostream
	leaq	_ZSt4cout(%rip), %rdx	#, _99
	addq	-24(%rax), %rdx	# MEM[(long int *)_96 + -24B], _99
# /usr/include/c++/15/bits/ios_base.h:87:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	movl	24(%rdx), %eax	# _99->_M_flags, _181
# /usr/include/c++/15/bits/ios_base.h:777:       _M_precision = __prec;
	movq	$3, 8(%rdx)	#, _99->_M_precision
# /usr/include/c++/15/bits/ios_base.h:87:   { return _Ios_Fmtflags(static_cast<int>(__a) & static_cast<int>(__b)); }
	andl	$-261, %eax	#, _181
# /usr/include/c++/15/bits/ios_base.h:92:   { return _Ios_Fmtflags(static_cast<int>(__a) | static_cast<int>(__b)); }
	orl	$4, %eax	#, tmp342
	movl	%eax, 24(%rdx)	# tmp342, MEM[(_Ios_Fmtflags &)_99 + 24]
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	leaq	.LC10(%rip), %rsi	#,
	movl	$41, %edx	#,
	leaq	_ZSt4cout(%rip), %rdi	#,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	vmovq	%xmm0, %r12	#, _50
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
	movl	$8, %edx	#,
	leaq	.LC11(%rip), %rsi	#,
	leaq	_ZSt4cout(%rip), %rdi	#,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rsi	# color.D.132534._M_impl.D.131869._M_finish, color.D.132534._M_impl.D.131869._M_finish
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp352
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	-432(%rbp), %rsi	# color.D.132534._M_impl.D.131869._M_start, _103
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rsi	#, tmp350
	imulq	%rax, %rsi	# tmp352, __dif_104
# /usr/include/c++/15/bits/ostream.h:179:       { return _M_insert(__n); }
	leaq	_ZSt4cout(%rip), %rdi	#,
	call	_ZNSo9_M_insertImEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$4, %edx	#,
	leaq	.LC12(%rip), %rsi	#,
	movq	%rax, %rdi	# _100,
# /usr/include/c++/15/bits/ostream.h:179:       { return _M_insert(__n); }
	movq	%rax, %rbx	#, _100
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:146:     std::cout << "Frames: " << color.size() << " at " << color[0].cols << "x" << color[0].rows
	movq	-432(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_start, color.D.132534._M_impl.D.131869._M_start
	movq	%rbx, %rdi	# _100,
	movl	12(%rax), %esi	# MEM[(struct value_type &)_106].cols, MEM[(struct value_type &)_106].cols
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$1, %edx	#,
	leaq	.LC13(%rip), %rsi	#,
	movq	%rax, %rdi	# _53,
# lab5.cpp:146:     std::cout << "Frames: " << color.size() << " at " << color[0].cols << "x" << color[0].rows
	movq	%rax, %rbx	#, _53
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:147:               << "; median of " << reps << " repetitions (ms/frame)\n"
	movq	-432(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_start, color.D.132534._M_impl.D.131869._M_start
	movq	%rbx, %rdi	# _53,
	movl	8(%rax), %esi	# MEM[(struct value_type &)_107].rows, MEM[(struct value_type &)_107].rows
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$12, %edx	#,
	leaq	.LC14(%rip), %rsi	#,
	movq	%rax, %rdi	# _56,
# lab5.cpp:147:               << "; median of " << reps << " repetitions (ms/frame)\n"
	movq	%rax, %rbx	#, _56
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:148:               << "Grayscale: " << grayMs << "\nSobel: " << sobelMs << "\nTotal: " << totalMs << "\n";
	movl	-460(%rbp), %esi	# reps,
	movq	%rbx, %rdi	# _56,
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$24, %edx	#,
	leaq	.LC15(%rip), %rsi	#,
	movq	%rax, %rdi	# _58,
# lab5.cpp:148:               << "Grayscale: " << grayMs << "\nSobel: " << sobelMs << "\nTotal: " << totalMs << "\n";
	movq	%rax, %rbx	#, _58
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
	movl	$11, %edx	#,
	leaq	.LC16(%rip), %rsi	#,
	movq	%rbx, %rdi	# _58,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	vmovq	%r15, %xmm0	# _46,
	movq	%rbx, %rdi	# _58,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$8, %edx	#,
	leaq	.LC17(%rip), %rsi	#,
	movq	%rax, %rdi	# _108,
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%rax, %rbx	#, _108
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	vmovsd	-488(%rbp), %xmm0	# %sfp,
	movq	%rbx, %rdi	# _108,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$8, %edx	#,
	leaq	.LC18(%rip), %rsi	#,
	movq	%rax, %rdi	# _109,
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%rax, %rbx	#, _109
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	vmovq	%r12, %xmm0	# _50,
	movq	%rbx, %rdi	# _109,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$1, %edx	#,
	leaq	.LC19(%rip), %rsi	#,
	movq	%rax, %rdi	# _110,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
.LEHE20:
# lab5.cpp:149: }
	movq	-472(%rbp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# lab5.cpp:149: }
	movq	%r13, %rdi	# tmp386,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# lab5.cpp:149: }
	movq	%r14, %rdi	# tmp393,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# /usr/include/c++/15/bits/basic_string.h:896:       { _M_dispose(); }
	movq	-504(%rbp), %rdi	# %sfp,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT	#
# lab5.cpp:149: }
	movq	-56(%rbp), %rax	# D.411998, tmp427
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp427
	jne	.L333	#,
	addq	$480, %rsp	#,
	popq	%rbx	#
	popq	%r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	xorl	%eax, %eax	#
	popq	%rbp	#
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L286:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:123: 	  _M_realloc_append(std::forward<_Args>(__args)...);
	movq	-480(%rbp), %rdi	# %sfp,
.LEHB21:
	call	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_	#
.LEHE21:
	jmp	.L287	#
.L328:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-424(%rbp), %rsi	# color.D.132534._M_impl.D.131869._M_finish, _156
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	-432(%rbp), %rax	# color.D.132534._M_impl.D.131869._M_start, _157
	jmp	.L293	#
.L327:
# /usr/include/stdlib.h:487:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	24(%r13), %rdi	# MEM[(char * *)argv_23(D) + 24B], MEM[(char * *)argv_23(D) + 24B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	movl	$3, %edx	#, tmp424
	cmpl	%edx, %eax	# tmp424, _82
	cmovl	%edx, %eax	# _82,, tmp424, iftmp.1_14
	jmp	.L282	#
.L279:
# /usr/include/c++/15/bits/char_traits.h:423: 	if (__n == 0)
	testq	%rax, %rax	# tmp402
	je	.L280	#,
	movq	%rbx, %rdi	# _133, _133
	jmp	.L278	#
.L332:
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$60, %edx	#,
	leaq	.LC6(%rip), %rsi	#,
	leaq	_ZSt4cerr(%rip), %rdi	#,
.LEHB22:
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
.LEHE22:
	jmp	.L291	#
.L330:
# /usr/include/c++/15/bits/stl_iterator.h:1059:       : _M_current(__i) { }
	movq	-424(%rbp), %rdx	# MEM[(const struct Mat * const &)&color + 8], _147
	movq	-432(%rbp), %rcx	# MEM[(const struct Mat * const &)&color], _148
	jmp	.L289	#
.L333:
# lab5.cpp:149: }
	call	__stack_chk_fail@PLT	#
.L310:
	endbr64	
	movq	%rax, %rbx	# tmp423, tmp378
	vzeroupper
	jmp	.L306	#
.L313:
	endbr64	
# lab5.cpp:113: }
	movq	%rax, %rbx	# tmp410, tmp285
	vzeroupper
	jmp	.L306	#
.L314:
	endbr64	
# lab5.cpp:110:         }
	jmp	.L300	#
.L315:
	endbr64	
# lab5.cpp:103:     }
	movq	%rax, %rbx	# tmp408, tmp277
	vzeroupper
	jmp	.L298	#
.L311:
	endbr64	
# lab5.cpp:149: }
	movq	%rax, %rbx	# tmp422, tmp373
	vzeroupper
	jmp	.L305	#
.L312:
	endbr64	
	movq	%rax, %rbx	#, tmp421
	jmp	.L304	#
.L316:
	endbr64	
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	jmp	.L297	#
	.section	.gcc_except_table
.LLSDA17249:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE17249-.LLSDACSB17249
.LLSDACSB17249:
	.uleb128 .LEHB11-.LFB17249
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB12-.LFB17249
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L314-.LFB17249
	.uleb128 0
	.uleb128 .LEHB13-.LFB17249
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L313-.LFB17249
	.uleb128 0
	.uleb128 .LEHB14-.LFB17249
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L314-.LFB17249
	.uleb128 0
	.uleb128 .LEHB15-.LFB17249
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L313-.LFB17249
	.uleb128 0
	.uleb128 .LEHB16-.LFB17249
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L315-.LFB17249
	.uleb128 0
	.uleb128 .LEHB17-.LFB17249
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L316-.LFB17249
	.uleb128 0
	.uleb128 .LEHB18-.LFB17249
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L310-.LFB17249
	.uleb128 0
	.uleb128 .LEHB19-.LFB17249
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L311-.LFB17249
	.uleb128 0
	.uleb128 .LEHB20-.LFB17249
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L312-.LFB17249
	.uleb128 0
	.uleb128 .LEHB21-.LFB17249
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L316-.LFB17249
	.uleb128 0
	.uleb128 .LEHB22-.LFB17249
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L315-.LFB17249
	.uleb128 0
.LLSDACSE17249:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC17249
	.type	main.cold, @function
main.cold:
.LFSB17249:
.L304:
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	.cfi_escape 0x10,0x6,0x2,0x76,0
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
# lab5.cpp:149: }
	movq	-472(%rbp), %rdi	# %sfp,
	vzeroupper
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
.L305:
	movq	%r13, %rdi	# tmp386,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
.L306:
	movq	-480(%rbp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# /usr/include/c++/15/bits/basic_string.h:896:       { _M_dispose(); }
	movq	-504(%rbp), %rdi	# %sfp,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT	#
	movq	-56(%rbp), %rax	# D.411998, tmp428
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp428
	jne	.L334	#,
	movq	%rbx, %rdi	# tmp291,
.LEHB23:
	call	_Unwind_Resume@PLT	#
.L300:
# lab5.cpp:110:         }
	movq	%rbx, %rdi	# tmp388,
	vzeroupper
	movq	%rax, %rbx	#, tmp285
	call	_ZN2cv3MatD1Ev@PLT	#
	jmp	.L306	#
.L297:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	movq	%rbx, %rdi	# tmp388,
	vzeroupper
	movq	%rax, %rbx	#, tmp277
	call	_ZN2cv3MatD1Ev@PLT	#
.L298:
# lab5.cpp:103:     }
	movq	%r13, %rdi	# tmp392,
	call	_ZN2cv3MatD1Ev@PLT	#
	movq	%r12, %rdi	# tmp389,
	call	_ZN2cv12VideoCaptureD1Ev@PLT	#
	jmp	.L306	#
.L334:
	call	__stack_chk_fail@PLT	#
.L322:
# /usr/include/c++/15/bits/basic_string.h:711: 	  std::__throw_logic_error(__N("basic_string: "
	movq	-56(%rbp), %rax	# D.411998, tmp426
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp426
	jne	.L335	#,
	leaq	.LC5(%rip), %rdi	#,
	call	_ZSt19__throw_logic_errorPKc@PLT	#
.LEHE23:
.L335:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE17249:
	.section	.gcc_except_table
.LLSDAC17249:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC17249-.LLSDACSBC17249
.LLSDACSBC17249:
	.uleb128 .LEHB23-.LCOLDB21
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSEC17249:
	.section	.text.unlikely
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE21:
	.section	.text.startup
.LHOTE21:
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1093567616
	.align 8
.LC2:
	.long	0
	.long	1071644672
	.align 8
.LC7:
	.long	0
	.long	1081081856
	.align 8
.LC8:
	.long	1
	.long	1
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.globl	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 15.2.0-16ubuntu1) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
