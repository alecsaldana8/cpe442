	.file	"lab5.cpp"
# GNU C++17 (Ubuntu 15.2.0-16ubuntu1) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O3 -std=c++17 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.p2align 4
	.type	_ZL9grayscaleRKN2cv3MatERS0_, @function
_ZL9grayscaleRKN2cv3MatERS0_:
.LFB10482:
	.cfi_startproc
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	movl	8(%rdi), %eax	# color_31(D)->rows,
# lab5.cpp:68: NOINLINE static void grayscale(const cv::Mat& color, cv::Mat& gray) {
	movq	%rsi, %r10	# gray, gray
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	testl	%eax, %eax	#
	jle	.L1	#,
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	movl	12(%rdi), %eax	# color_31(D)->cols, _24
	xorl	%r9d, %r9d	# ivtmp.615
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	testl	%eax, %eax	# _24
	jle	.L1	#,
	.p2align 4
	.p2align 3
.L10:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	movq	72(%r10), %rax	# gray_33(D)->step.p, gray_33(D)->step.p
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	xorl	%ecx, %ecx	# ivtmp.608
	movq	(%rax), %r8	# *_32, _40
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	72(%rdi), %rax	# color_31(D)->step.p, color_31(D)->step.p
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	(%rax), %rdx	# *_42, _45
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:716:     return (_Tp*)(data + step.p[0] * y);
	imulq	%r9, %r8	# ivtmp.615, _40
	addq	16(%r10), %r8	# gray_33(D)->data, _96
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	imulq	%r9, %rdx	# ivtmp.615, _45
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	addq	16(%rdi), %rdx	# color_31(D)->data, ivtmp.610
	.p2align 6
	.p2align 4
	.p2align 3
.L4:
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	movzbl	(%rdx), %eax	# MEM[(const uchar *)_93], _5
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	movzbl	1(%rdx), %esi	# MEM[(const uchar *)_93 + 1B], _11
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	addq	$3, %rdx	#, ivtmp.610
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	imull	$732, %esi, %esi	#, _11, _12
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	imull	$74, %eax, %eax	#, _5, _6
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	addl	%esi, %eax	# _12, _13
# lab5.cpp:74:                           + 218 * in[3 * x + 2] + 512;
	movzbl	-1(%rdx), %esi	# MEM[(const uchar *)_93 + 2B], _17
# lab5.cpp:74:                           + 218 * in[3 * x + 2] + 512;
	imull	$218, %esi, %esi	#, _17, _18
# lab5.cpp:73:             const int sum = 74 * in[3 * x] + 732 * in[3 * x + 1]
	leal	512(%rax,%rsi), %eax	#, sum_36
# lab5.cpp:75:             out[x] = static_cast<uchar>(sum >> 10);
	sarl	$10, %eax	#, _20
# lab5.cpp:75:             out[x] = static_cast<uchar>(sum >> 10);
	movb	%al, (%r8,%rcx)	# _20, MEM[(uchar *)_96 + ivtmp.608_88 * 1]
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	movl	12(%rdi), %eax	# color_31(D)->cols, _24
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	addq	$1, %rcx	#, ivtmp.608
	cmpl	%ecx, %eax	# ivtmp.608, _24
	jg	.L4	#,
# lab5.cpp:69:     for (int y = 0; y < color.rows; ++y) {
	leal	1(%r9), %edx	#, _38
	cmpl	8(%rdi), %edx	# color_31(D)->rows, _38
	jge	.L1	#,
	addq	$1, %r9	#, ivtmp.615
# lab5.cpp:72:         for (int x = 0; x < color.cols; ++x) {
	testl	%eax, %eax	# _24
	jg	.L10	#,
.L1:
# lab5.cpp:78: }
	ret	
	.cfi_endproc
.LFE10482:
	.size	_ZL9grayscaleRKN2cv3MatERS0_, .-_ZL9grayscaleRKN2cv3MatERS0_
	.p2align 4
	.type	_ZL5sobelRKN2cv3MatERS0_, @function
_ZL5sobelRKN2cv3MatERS0_:
.LFB10483:
	.cfi_startproc
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	cmpl	$2, 8(%rdi)	#, gray_57(D)->rows
	jle	.L20	#,
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
	movl	12(%rdi), %edx	# gray_57(D)->cols, _48
	movl	$1, %ebx	#, ivtmp.633
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	$2, %edx	#, _48
	jle	.L11	#,
	.p2align 4
	.p2align 3
.L23:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	72(%r11), %rax	# gray_57(D)->step.p, gray_57(D)->step.p
	leaq	-1(%rbx), %r10	#, _320
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	16(%r11), %rsi	# gray_57(D)->data, _74
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	(%rax), %rdx	# *_75, _76
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:723:     return (const _Tp*)(data + step.p[0] * y);
	movq	%rdx, %rax	# _76, _72
	movq	%rdx, %rdi	# _76, _78
	imulq	%rbx, %rax	# ivtmp.633, _72
	imulq	%r10, %rdi	# _320, _78
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
	xorl	%eax, %eax	# ivtmp.623
	addq	16(%rbp), %r10	# out_60(D)->data, _325
	.p2align 4
	.p2align 3
.L14:
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	(%rdi,%rax), %r13d	# MEM[(const uchar *)_79 + ivtmp.623_327 * 1], _10
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movzbl	1(%rdi,%rax), %r14d	# MEM[(const uchar *)_79 + 1B + ivtmp.623_327 * 1], _33
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%rdi,%rax), %ecx	# MEM[(const uchar *)_79 + 2B + ivtmp.623_327 * 1], _7
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	(%rsi,%rax), %r12d	# MEM[(const uchar *)_70 + ivtmp.623_327 * 1], _24
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movl	%r13d, %edx	# _10, _29
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	addl	%r14d, %r14d	# _34
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%rsi,%rax), %r8d	# MEM[(const uchar *)_70 + 2B + ivtmp.623_327 * 1], _28
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	negl	%edx	# _29
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	subl	%r14d, %edx	# _34, _35
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	movzbl	1(%rsi,%rax), %r14d	# MEM[(const uchar *)_70 + 1B + ivtmp.623_327 * 1], _40
# lab5.cpp:88:             const int gy = -a[x] - 2 * a[x + 1] - a[x + 2] + c[x] + 2 * c[x + 1] + c[x + 2];
	subl	%ecx, %edx	# _7, _36
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
	movzbl	(%r9,%rax), %r13d	# MEM[(const uchar *)_73 + ivtmp.623_327 * 1], _14
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	addl	%r13d, %r13d	# _15
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	subl	%r13d, %ecx	# _15, _16
# lab5.cpp:87:             const int gx = -a[x] + a[x + 2] - 2 * b[x] + 2 * b[x + 2] - c[x] + c[x + 2];
	movzbl	2(%r9,%rax), %r13d	# MEM[(const uchar *)_73 + 2B + ivtmp.623_327 * 1], _19
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
	movb	%dl, (%r10,%rax)	# _45, MEM[(uchar *)_325 + ivtmp.623_327 * 1]
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	movl	12(%r11), %edx	# gray_57(D)->cols, _48
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	addq	$1, %rax	#, ivtmp.623
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	leal	-2(%rdx), %ecx	#, _49
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	%eax, %ecx	# ivtmp.623, _49
	jg	.L14	#,
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	movl	8(%r11), %eax	# gray_57(D)->rows, tmp202
	subl	$2, %eax	#, _17
# lab5.cpp:81:     for (int y = 0; y < gray.rows - 2; ++y) {
	cmpl	%ebx, %eax	# ivtmp.633, _17
	jle	.L11	#,
	addq	$1, %rbx	#, ivtmp.633
# lab5.cpp:86:         for (int x = 0; x < gray.cols - 2; ++x) {
	cmpl	$2, %edx	#, _48
	jg	.L23	#,
.L11:
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
.L20:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE10483:
	.size	_ZL5sobelRKN2cv3MatERS0_, .-_ZL5sobelRKN2cv3MatERS0_
	.p2align 4
	.type	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, @function
_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0:
.LFB15491:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	leaq	-1(%rdx), %r10	#, tmp143
# /usr/include/c++/15/bits/stl_heap.h:224:     __adjust_heap(_RandomAccessIterator __first, _Distance __holeIndex,
	movq	%rsi, %r8	# __holeIndex, __holeIndex
	movapd	%xmm0, %xmm2	# __value, __value
	movq	%rdx, %r11	# __len, __len
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	shrq	$63, %r10	#, tmp143
	leaq	-1(%r10,%rdx), %r10	#, tmp144
	sarq	%r10	# _71
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	cmpq	%r10, %rsi	# _71, __holeIndex
	jge	.L25	#,
	movq	%rsi, %rdx	# __holeIndex, __holeIndex
	jmp	.L28	#
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L34:
	movq	%rcx, %rdx	# __secondChild, __holeIndex
.L28:
# /usr/include/c++/15/bits/stl_heap.h:231: 	  __secondChild = 2 * (__secondChild + 1);
	leaq	1(%rdx), %rax	#, _119
# /usr/include/c++/15/bits/stl_heap.h:231: 	  __secondChild = 2 * (__secondChild + 1);
	leaq	(%rax,%rax), %rcx	#, __secondChild
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	salq	$4, %rax	#, _105
# /usr/include/c++/15/bits/stl_heap.h:232: 	  if (__comp(__first + __secondChild,
	leaq	-1(%rcx), %rsi	#, _117
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	addq	%rdi, %rax	# __first, prephitmp_100
	leaq	(%rdi,%rsi,8), %r9	#, _107
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	(%rax), %xmm0	# *_104, prephitmp_99
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	(%r9), %xmm1	# *_107, _102
# /usr/include/c++/15/bits/stl_heap.h:232: 	  if (__comp(__first + __secondChild,
	comisd	%xmm0, %xmm1	# prephitmp_99, _102
# /usr/include/c++/15/bits/stl_heap.h:234: 	    __secondChild--;
	maxsd	%xmm0, %xmm1	# prephitmp_99, _102
	cmova	%rsi, %rcx	# _117,, __secondChild
	cmova	%r9, %rax	# _107,, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:235: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first + __secondChild));
	movsd	%xmm1, (%rdi,%rdx,8)	# _102, *_96
# /usr/include/c++/15/bits/stl_heap.h:229:       while (__secondChild < (__len - 1) / 2)
	cmpq	%rcx, %r10	# __secondChild, _71
	jg	.L34	#,
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	testb	$1, %r11b	#, __len
	je	.L40	#,
.L29:
# /usr/include/c++/15/bits/stl_heap.h:139:       _Distance __parent = (__holeIndex - 1) / 2;
	leaq	-1(%rcx), %rdx	#, tmp155
	shrq	$63, %rdx	#, tmp155
	leaq	-1(%rdx,%rcx), %rdx	#, tmp156
	sarq	%rdx	# __parent
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	cmpq	%r8, %rcx	# __holeIndex, __secondChild
	jg	.L32	#,
	jmp	.L30	#
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L42:
# /usr/include/c++/15/bits/stl_heap.h:142: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first + __parent));
	movsd	%xmm0, (%rax)	# _47, *_151
# /usr/include/c++/15/bits/stl_heap.h:144: 	  __parent = (__holeIndex - 1) / 2;
	leaq	-1(%rdx), %rax	#, tmp160
	movq	%rdx, %rcx	# __parent, __secondChild
	shrq	$63, %rax	#, tmp160
	leaq	-1(%rax,%rdx), %rax	#, tmp161
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	cmpq	%rdx, %r8	# __parent, __holeIndex
	jge	.L41	#,
	sarq	%rax	# tmp161
	movq	%rax, %rdx	# tmp161, __parent
.L32:
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rdx,8), %rsi	#, _46
	leaq	(%rdi,%rcx,8), %rax	#, prephitmp_100
# /usr/include/c++/15/bits/predefined_ops.h:69:       { return *__it < __val; }
	movsd	(%rsi), %xmm0	# *_46, _47
# /usr/include/c++/15/bits/stl_heap.h:140:       while (__holeIndex > __topIndex && __comp(__first + __parent, __value))
	comisd	%xmm0, %xmm2	# _47, __value
	ja	.L42	#,
.L30:
# /usr/include/c++/15/bits/stl_heap.h:146:       *(__first + __holeIndex) = _GLIBCXX_MOVE(__value);
	movsd	%xmm2, (%rax)	# __value, *prephitmp_148
# /usr/include/c++/15/bits/stl_heap.h:249:     }
	ret	
	.p2align 4,,10
	.p2align 3
.L40:
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	subq	$2, %r11	#, _26
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	sarq	%r11	# _27
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	cmpq	%rcx, %r11	# __secondChild, _27
	jne	.L29	#,
.L33:
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	leaq	1(%rcx,%rcx), %rcx	#, __secondChild
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rcx,8), %rdx	#, _33
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	movsd	(%rdx), %xmm0	# MEM[(type &)_33], _34
# /usr/include/c++/15/bits/stl_heap.h:241: 	  *(__first + __holeIndex) = _GLIBCXX_MOVE(*(__first
	movsd	%xmm0, (%rax)	# _34, *prephitmp_5
	movq	%rdx, %rax	# _33, prephitmp_100
	jmp	.L29	#
	.p2align 4,,10
	.p2align 3
.L41:
	movq	%rsi, %rax	# _46, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:146:       *(__first + __holeIndex) = _GLIBCXX_MOVE(__value);
	movsd	%xmm2, (%rax)	# __value, *prephitmp_148
# /usr/include/c++/15/bits/stl_heap.h:249:     }
	ret	
	.p2align 4,,10
	.p2align 3
.L25:
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rsi,8), %rax	#, prephitmp_100
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	testb	$1, %dl	#, __len
	jne	.L30	#,
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	subq	$2, %r11	#, _137
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	sarq	%r11	# _138
# /usr/include/c++/15/bits/stl_heap.h:238:       if ((__len & 1) == 0 && __secondChild == (__len - 2) / 2)
	cmpq	%r11, %rsi	# _138, __holeIndex
	jne	.L30	#,
	movq	%r8, %rcx	# __holeIndex, __secondChild
	jmp	.L33	#
	.cfi_endproc
.LFE15491:
	.size	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0, .-_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0
	.p2align 4
	.type	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0, @function
_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0:
.LFB15492:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_algo.h:1774:       if (__first == __last) return;
	cmpq	%rsi, %rdi	# __last, __first
	je	.L63	#,
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
	jne	.L53	#,
	jmp	.L43	#
	.p2align 4,,10
	.p2align 3
.L66:
# /usr/include/c++/15/bits/stl_iterator_base_funcs.h:108:       return __last - __first;
	movq	%rbx, %rdx	# __i$_M_current, _23
	subq	%rbp, %rdx	# __first, _23
# /usr/include/c++/15/bits/stl_iterator_base_funcs.h:197: 	__i += __n;
	movq	%rdx, %rax	# _23, tmp116
	salq	$61, %rax	#, tmp116
	subq	%rdx, %rax	# _23, _30
	leaq	8(%rbx,%rax), %rdi	#, _31
# /usr/include/c++/15/bits/stl_algobase.h:702: 	  if (__builtin_expect(__n > 1, true))
	cmpq	$8, %rdx	#, _23
	jle	.L47	#,
# /usr/include/c++/15/bits/stl_algobase.h:704: 	      __builtin_memmove(_GLIBCXX_TO_ADDR(__result),
	movq	%rbp, %rsi	# __first,
	movsd	%xmm1, 8(%rsp)	# _5, %sfp
	call	memmove@PLT	#
	movsd	8(%rsp), %xmm1	# %sfp, _5
.L48:
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1783: 	      *__first = _GLIBCXX_MOVE(__val);
	movsd	%xmm1, 0(%rbp)	# _5, *__first_1
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	cmpq	%rbx, %r12	# __i$_M_current, __last
	je	.L43	#,
.L53:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	(%rbx), %xmm1	# MEM[(double &)__i$_M_current_26], _5
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	0(%rbp), %xmm0	# *__first_1, _6
# /usr/include/c++/15/bits/stl_algo.h:1778: 	  if (__comp(__i, __first))
	comisd	%xmm1, %xmm0	# _5, _6
	ja	.L66	#,
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	movsd	-8(%rbx), %xmm0	# MEM[(double &)__i$_M_current_26 + 18446744073709551608], _9
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	leaq	-8(%rbx), %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	comisd	%xmm1, %xmm0	# _5, _9
	jbe	.L61	#,
	.p2align 5
	.p2align 4
	.p2align 3
.L52:
# /usr/include/c++/15/bits/stl_algo.h:1760: 	  *__last = _GLIBCXX_MOVE(*__next);
	movsd	%xmm0, 8(%rax)	# _9, MEM[(double &)__next$_M_current_7 + 8]
	movq	%rax, %rdx	# __next$_M_current, __last$_M_current
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	movsd	-8(%rax), %xmm0	# MEM[(double &)_12], _9
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	comisd	%xmm1, %xmm0	# _5, _9
	ja	.L52	#,
.L50:
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __i$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1764:       *__last = _GLIBCXX_MOVE(__val);
	movsd	%xmm1, (%rdx)	# _5, *__last$_M_current_34
# /usr/include/c++/15/bits/stl_algo.h:1776:       for (_RandomAccessIterator __i = __first + 1; __i != __last; ++__i)
	cmpq	%rbx, %r12	# __i$_M_current, __last
	jne	.L53	#,
.L43:
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
.L47:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_algobase.h:708: 	  else if (__n == 1)
	jne	.L48	#,
# /usr/include/c++/15/bits/stl_algobase.h:404: 	*__out = std::move(*__in);
	movsd	%xmm0, (%rdi)	# _6, *_31
# /usr/include/c++/15/bits/stl_algobase.h:408:     }
	jmp	.L48	#
.L61:
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	movq	%rbx, %rdx	# __i$_M_current, __last$_M_current
	jmp	.L50	#
.L63:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret	
	.cfi_endproc
.LFE15492:
	.size	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0, .-_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0
	.p2align 4
	.type	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0, @function
_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0:
.LFB15494:
	.cfi_startproc
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rsi, %rax	# __last, _7
	subq	%rdi, %rax	# __first, _7
# /usr/include/c++/15/bits/stl_algo.h:1881:       while (__last - __first > int(_S_threshold))
	cmpq	$128, %rax	#, _7
	jle	.L117	#,
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rax, %r14	# _7, _163
	sarq	$4, %rax	#, _164
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdx, %r13	# __depth_limit, __depth_limit
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	sarq	$3, %r14	#, _163
# /usr/include/c++/15/bits/stl_algo.h:1877:     __introsort_loop(_RandomAccessIterator __first,
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12	# __last, __last
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp	# __first, __first
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# /usr/include/c++/15/bits/stl_algo.h:1883: 	  if (__depth_limit == 0)
	testq	%r13, %r13	# __depth_limit
	je	.L118	#,
.L69:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movupd	0(%rbp), %xmm2	# MEM <vector(2) double> [(type &)__first_9], MEM <vector(2) double> [(type &)__first_9]
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	0(%rbp,%rax,8), %rax	#, _63
# /usr/include/c++/15/bits/stl_algo.h:1888: 	  --__depth_limit;
	subq	$1, %r13	#, __depth_limit
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	-8(%r12), %xmm4	# MEM[(double &)__last_118 + 18446744073709551608], pretmp_161
	movsd	(%rax), %xmm3	# *_63, _80
# /usr/include/c++/15/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	8(%rbp), %rbx	#, __first$_M_current
	movapd	%xmm2, %xmm5	# MEM <vector(2) double> [(type &)__first_9], MEM <vector(2) double> [(type &)__first_9]
	movapd	%xmm2, %xmm1	# MEM <vector(2) double> [(type &)__first_9], prephitmp_83
	unpckhpd	%xmm5, %xmm5	# MEM <vector(2) double> [(type &)__first_9]
# /usr/include/c++/15/bits/stl_algo.h:91:       if (__comp(__a, __b))
	comisd	%xmm5, %xmm3	# pretmp_81, _80
	movapd	%xmm5, %xmm0	# MEM <vector(2) double> [(type &)__first_9], pretmp_81
	jbe	.L107	#,
# /usr/include/c++/15/bits/stl_algo.h:93: 	  if (__comp(__b, __c))
	comisd	%xmm3, %xmm4	# _80, pretmp_161
	ja	.L109	#,
# /usr/include/c++/15/bits/stl_algo.h:95: 	  else if (__comp(__a, __c))
	comisd	%xmm5, %xmm4	# pretmp_81, pretmp_161
	ja	.L115	#,
.L81:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	shufpd	$1, %xmm2, %xmm2	#, MEM <vector(2) double> [(type &)__first_9], _45
	movups	%xmm2, 0(%rbp)	# _45, MEM <vector(2) double> [(double &)__first_9]
.L80:
	movq	%r12, %rdx	# __last, __last$_M_current
	jmp	.L116	#
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L88:
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	8(%rbx), %xmm1	# MEM[(double &)_67], prephitmp_83
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __first$_M_current
.L116:
# /usr/include/c++/15/bits/stl_algo.h:1836: 	  while (__comp(__first, __pivot))
	comisd	%xmm1, %xmm0	# prephitmp_83, pretmp_81
	ja	.L88	#,
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	-8(%rdx), %xmm2	# MEM[(double &)__last$_M_current_70 + 18446744073709551608], _74
	leaq	-16(%rdx), %rax	#, ivtmp.702
# /usr/include/c++/15/bits/stl_algo.h:1839: 	  while (__comp(__pivot, __last))
	comisd	%xmm0, %xmm2	# pretmp_81, _74
	jbe	.L110	#,
	.p2align 5
	.p2align 4
	.p2align 3
.L91:
	movq	%rax, %rdx	# ivtmp.702, ivtmp.702
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	(%rax), %xmm2	# MEM[(double &)_142 + 8], _74
# /usr/include/c++/15/bits/stl_algo.h:1839: 	  while (__comp(__pivot, __last))
	subq	$8, %rax	#, ivtmp.702
	comisd	%xmm0, %xmm2	# pretmp_81, _74
	ja	.L91	#,
# /usr/include/c++/15/bits/stl_algo.h:1841: 	  if (!(__first < __last))
	cmpq	%rdx, %rbx	# __last$_M_current, __first$_M_current
	jnb	.L119	#,
.L93:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	movsd	%xmm2, (%rbx)	# _74, *__first$_M_current_41
# /usr/include/c++/15/bits/stl_iterator.h:1103: 	++_M_current;
	addq	$8, %rbx	#, __first$_M_current
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	movsd	%xmm1, (%rdx)	# prephitmp_83, *__last$_M_current_130
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	(%rbx), %xmm1	# MEM[(double &)__first$_M_current_41 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
# /usr/include/c++/15/bits/stl_iterator.h:1104: 	return *this;
	jmp	.L116	#
.L107:
# /usr/include/c++/15/bits/stl_algo.h:100:       else if (__comp(__a, __c))
	comisd	%xmm5, %xmm4	# pretmp_81, pretmp_161
	ja	.L81	#,
# /usr/include/c++/15/bits/stl_algo.h:102:       else if (__comp(__b, __c))
	comisd	%xmm3, %xmm4	# _80, pretmp_161
	jbe	.L109	#,
.L115:
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	movsd	%xmm4, 0(%rbp)	# pretmp_161, *__first_9
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	movsd	%xmm1, -8(%r12)	# prephitmp_83, MEM[(double &)__last_118 + 18446744073709551608]
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	8(%rbp), %xmm1	# MEM[(double &)__first_9 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
	jmp	.L80	#
	.p2align 4,,10
	.p2align 3
.L110:
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rdx	#, __last$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1841: 	  if (!(__first < __last))
	cmpq	%rdx, %rbx	# __last$_M_current, __first$_M_current
	jb	.L93	#,
	.p2align 4
	.p2align 3
.L119:
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
	jle	.L67	#,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rax, %r14	# _7, _163
	movq	%rbx, %r12	# __first$_M_current, __last
	sarq	$4, %rax	#, _164
	sarq	$3, %r14	#, _163
# /usr/include/c++/15/bits/stl_algo.h:1883: 	  if (__depth_limit == 0)
	testq	%r13, %r13	# __depth_limit
	jne	.L69	#,
.L118:
# /usr/include/c++/15/bits/stl_heap.h:352:       _DistanceType __parent = (__len - 2) / 2;
	leaq	-1(%rax), %rbx	#, __parent
	jmp	.L71	#
.L120:
# /usr/include/c++/15/bits/stl_heap.h:360: 	  __parent--;
	subq	$1, %rbx	#, __parent
.L71:
# /usr/include/c++/15/bits/stl_heap.h:355: 	  _ValueType __value = _GLIBCXX_MOVE(*(__first + __parent));
	movsd	0(%rbp,%rbx,8), %xmm0	# MEM[(type &)__first_9 + _106 * 8], _54
# /usr/include/c++/15/bits/stl_heap.h:356: 	  std::__adjust_heap(__first, __parent, __len, _GLIBCXX_MOVE(__value),
	movq	%r14, %rdx	# _163,
	movq	%rbx, %rsi	# __parent,
	movq	%rbp, %rdi	# __first,
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0	#
# /usr/include/c++/15/bits/stl_heap.h:358: 	  if (__parent == 0)
	testq	%rbx, %rbx	# __parent
	jne	.L120	#,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rax	# __last, _42
	leaq	-8(%r12), %rbx	#, ivtmp.681
	subq	%rbp, %rax	# __first, _42
# /usr/include/c++/15/bits/stl_heap.h:422:       while (__last - __first > 1)
	cmpq	$8, %rax	#, _42
	jle	.L67	#,
	.p2align 4
	.p2align 3
.L74:
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%rbx, %r12	# ivtmp.681, _32
# /usr/include/c++/15/bits/stl_heap.h:263:       *__result = _GLIBCXX_MOVE(*__first);
	movsd	0(%rbp), %xmm1	# MEM[(type &)__first_9], _31
# /usr/include/c++/15/bits/stl_heap.h:262:       _ValueType __value = _GLIBCXX_MOVE(*__result);
	movsd	(%rbx), %xmm0	# MEM[(type &)_28], _29
# /usr/include/c++/15/bits/stl_heap.h:264:       std::__adjust_heap(__first, _DistanceType(0),
	xorl	%esi, %esi	#
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	subq	%rbp, %r12	# __first, _32
# /usr/include/c++/15/bits/stl_heap.h:264:       std::__adjust_heap(__first, _DistanceType(0),
	movq	%rbp, %rdi	# __first,
# /usr/include/c++/15/bits/stl_heap.h:422:       while (__last - __first > 1)
	subq	$8, %rbx	#, ivtmp.681
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rdx	# _32, _33
# /usr/include/c++/15/bits/stl_heap.h:263:       *__result = _GLIBCXX_MOVE(*__first);
	movsd	%xmm1, 8(%rbx)	# _31, MEM[(double &)_28]
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	sarq	$3, %rdx	#, _33
# /usr/include/c++/15/bits/stl_heap.h:264:       std::__adjust_heap(__first, _DistanceType(0),
	call	_ZSt13__adjust_heapIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEEldNS0_5__ops15_Iter_less_iterEEvT_T0_SA_T1_T2_.isra.0	#
# /usr/include/c++/15/bits/stl_heap.h:422:       while (__last - __first > 1)
	cmpq	$8, %r12	#, _32
	jg	.L74	#,
.L67:
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
.L109:
	.cfi_restore_state
# /usr/include/c++/15/bits/move.h:236:       __a = _GLIBCXX_MOVE(__b);
	movsd	%xmm3, 0(%rbp)	# _80, *__first_9
# /usr/include/c++/15/bits/move.h:237:       __b = _GLIBCXX_MOVE(__tmp);
	movsd	%xmm1, (%rax)	# prephitmp_83, *_63
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	8(%rbp), %xmm1	# MEM[(double &)__first_9 + 8], prephitmp_83
# /usr/include/c++/15/bits/predefined_ops.h:45:       { return *__it1 < *__it2; }
	movsd	0(%rbp), %xmm0	# *__first_9, pretmp_81
	jmp	.L80	#
.L117:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE15494:
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
.LFB10502:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA10502
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
	js	.L160	#,
	movq	%rdi, %r14	# __closure, __closure
	movl	%esi, %ebp	# stage, stage
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	xorl	%r13d, %r13d	# __new_finish
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movl	$-1, %r12d	#, r
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 16(%rsp)	#, %sfp
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rbx	#, tmp297
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 24(%rsp)	#, %sfp
	cmpl	$1, %esi	#, stage
	je	.L196	#,
	.p2align 4
	.p2align 3
.L123:
# lab5.cpp:129:             const auto start = Clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r15d, %r15d	# i
# lab5.cpp:129:             const auto start = Clock::now();
	movq	%rax, 8(%rsp)	#, %sfp
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rax	# __closure_18(D)->__color, _126
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rax), %rsi	# MEM[(const struct vector *)_126].D.94849._M_impl.D.94184._M_start, _58
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rax), %rax	# MEM[(const struct vector *)_126].D.94849._M_impl.D.94184._M_finish, MEM[(const struct vector *)_126].D.94849._M_impl.D.94184._M_finish
	subq	%rsi, %rax	# _58, _211
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp295
	imulq	%rbx, %rax	# tmp297, __dif
	jmp	.L137	#
	.p2align 4,,10
	.p2align 3
.L140:
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
	leaq	(%r15,%r15,2), %r11	#, _278
	salq	$5, %r11	#, tmp301
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rcx	# pretmp_310->D.94849._M_impl.D.94184._M_start, _313
	leaq	(%rsi,%r11), %rdi	#, _28
	addq	%r11, %rcx	# tmp301, _313
# lab5.cpp:131:                 if (stage != 1) grayscale(color[i], gray[i]);
	movq	%rcx, %rsi	# _313,
	call	_ZL9grayscaleRKN2cv3MatERS0_	#
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	testl	%ebp, %ebp	# stage
	je	.L138	#,
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	24(%r14), %rax	# __closure_18(D)->__edges, __closure_18(D)->__edges
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rsi	# _2->D.94849._M_impl.D.94184._M_start, _47
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rdi	# _3->D.94849._M_impl.D.94184._M_start, tmp301
	addq	%r11, %rsi	# tmp301, _47
	addq	%r11, %rdi	# tmp301, tmp301
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	call	_ZL5sobelRKN2cv3MatERS0_	#
.L138:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rax	# __closure_18(D)->__color, _4
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r15	#, i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rax), %rsi	#* _4, _58
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rax), %rax	#, MEM[(const struct vector *)_4].D.94849._M_impl.D.94184._M_finish
	subq	%rsi, %rax	# _58, _50
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp319
	imulq	%rbx, %rax	# tmp297, __dif
.L137:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r15	# __dif, i
	jb	.L140	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cmpl	$-1, %r12d	#, r
	je	.L141	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _5
# /usr/include/c++/15/bits/chrono.h:720: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	subq	8(%rsp), %rax	# %sfp, _63
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	pxor	%xmm0, %xmm0	# _59
	cvtsi2sdq	%rax, %xmm0	# _63, _59
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	pxor	%xmm1, %xmm1	# _6
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	divsd	.LC0(%rip), %xmm0	#, _60
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_5].D.94849._M_impl.D.94184._M_finish, MEM[(const struct vector *)_5].D.94849._M_impl.D.94184._M_finish
	subq	(%rdx), %rax	# MEM[(const struct vector *)_5].D.94849._M_impl.D.94184._M_start, _55
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp329
	imulq	%rbx, %rax	# tmp297, __dif_56
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cvtsi2sdq	%rax, %xmm1	# __dif_56, _6
	divsd	%xmm1, %xmm0	# _6, _7
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	%r13, 16(%rsp)	# __new_finish, %sfp
	je	.L142	#,
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	%xmm0, 0(%r13)	# _7, *samples$_M_finish_22
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$8, %r13	#, __new_finish
.L141:
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movq	(%r14), %rax	# __closure_18(D)->__reps, __closure_18(D)->__reps
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	addl	$1, %r12d	#, r
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	cmpl	%r12d, (%rax)	# r, *_8
	jg	.L123	#,
.L136:
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	subq	24(%rsp), %r13	# %sfp, __new_finish
	movq	%r13, %r12	# __new_finish, _125
	je	.L122	#,
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%r13, %rdi	# _125,
	movq	%r13, %r14	# _125, _82
.LEHB0:
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/stl_uninitialized.h:273: 	      __builtin_memcpy(std::__niter_base(__result),
	movq	24(%rsp), %rsi	# %sfp,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	movq	%r12, %rbp	# _125, _171
# /usr/include/c++/15/bits/stl_uninitialized.h:273: 	      __builtin_memcpy(std::__niter_base(__result),
	movq	%r12, %rdx	# _125,
	movq	%rax, %rdi	# _80,
# /usr/include/c++/15/bits/stl_iterator.h:1340:     { return __lhs.base() - __rhs.base(); }
	sarq	$3, %rbp	#, _171
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r15	# _80, _80
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	(%rax,%r13), %r13	#, _109
# /usr/include/c++/15/bits/stl_uninitialized.h:273: 	      __builtin_memcpy(std::__niter_base(__result),
	call	memcpy@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	bsrq	%rbp, %rdx	# _171, tmp388
# /usr/include/c++/15/bits/stl_algo.h:1906: 	  std::__introsort_loop(__first, __last,
	movq	%r13, %rsi	# _109,
	movq	%r15, %rdi	# _80,
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	movslq	%edx, %rdx	# tmp388, _176
# /usr/include/c++/15/bits/stl_algobase.h:1555:       return std::__bit_width(make_unsigned_t<_Tp>(__n)) - 1;
	movq	%rbp, %rbx	# _171, _70
# /usr/include/c++/15/bits/stl_algo.h:1906: 	  std::__introsort_loop(__first, __last,
	addq	%rdx, %rdx	# _177
	call	_ZSt16__introsort_loopIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEElNS0_5__ops15_Iter_less_iterEEvT_S9_T0_T1_.isra.0	#
# /usr/include/c++/15/bits/stl_algo.h:1816:       if (__last - __first > int(_S_threshold))
	cmpq	$128, %r12	#, _125
	jg	.L197	#,
# /usr/include/c++/15/bits/stl_algo.h:1823: 	std::__insertion_sort(__first, __last, __comp);
	movq	%r13, %rsi	# _109,
	movq	%r15, %rdi	# _80,
	call	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0	#
.L154:
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	testb	$1, %bpl	#, _171
	je	.L148	#,
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	%rbp, %r8	# _171, _171
	shrq	%r8	# _171
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	(%r15,%r8,8), %rbx	# *_155, <retval>
.L155:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r14, %rsi	# _82,
	movq	%r15, %rdi	# _80,
	call	_ZdlPvm@PLT	#
.L156:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	testq	%rdi, %rdi	# samples$_M_start
	je	.L121	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L121:
# lab5.cpp:137:     };
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbx, %xmm0	# <retval>,
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
.L197:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_algo.h:1818: 	  std::__insertion_sort(__first, __first + int(_S_threshold), __comp);
	leaq	128(%r15), %rsi	#,
	movq	%r15, %rdi	# _80,
	call	_ZSt16__insertion_sortIN9__gnu_cxx17__normal_iteratorIPdSt6vectorIdSaIdEEEENS0_5__ops15_Iter_less_iterEEvT_S9_T0_.isra.0	#
	leaq	128(%r15), %rcx	#, ivtmp.738
	.p2align 4
	.p2align 3
.L153:
# /usr/include/c++/15/bits/stl_algo.h:1755: 	__val = _GLIBCXX_MOVE(*__last);
	movsd	(%rcx), %xmm1	# MEM[(type &)__i$_M_current_133], _183
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	movsd	-8(%rcx), %xmm0	# MEM[(double &)__i$_M_current_133 + 18446744073709551608], _145
	movq	%rcx, %rdx	# ivtmp.738, __i$_M_current
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	leaq	-8(%rcx), %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	comisd	%xmm1, %xmm0	# _183, _145
	jbe	.L150	#,
	.p2align 5
	.p2align 4
	.p2align 3
.L152:
# /usr/include/c++/15/bits/stl_algo.h:1760: 	  *__last = _GLIBCXX_MOVE(*__next);
	movsd	%xmm0, 8(%rax)	# _145, MEM[(double &)__next$_M_current_96 + 8]
	movq	%rax, %rdx	# __next$_M_current, __i$_M_current
# /usr/include/c++/15/bits/predefined_ops.h:98:       { return __val < *__it; }
	movsd	-8(%rax), %xmm0	# MEM[(double &)_188], _145
# /usr/include/c++/15/bits/stl_iterator.h:1120: 	--_M_current;
	subq	$8, %rax	#, __next$_M_current
# /usr/include/c++/15/bits/stl_algo.h:1758:       while (__comp(__val, __next))
	comisd	%xmm1, %xmm0	# _183, _145
	ja	.L152	#,
.L150:
# /usr/include/c++/15/bits/stl_algo.h:1798:       for (_RandomAccessIterator __i = __first; __i != __last; ++__i)
	addq	$8, %rcx	#, ivtmp.738
# /usr/include/c++/15/bits/stl_algo.h:1764:       *__last = _GLIBCXX_MOVE(__val);
	movsd	%xmm1, (%rdx)	# _183, *__last$_M_current_95
# /usr/include/c++/15/bits/stl_algo.h:1798:       for (_RandomAccessIterator __i = __first; __i != __last; ++__i)
	cmpq	%r13, %rcx	# _109, ivtmp.738
	jne	.L153	#,
	jmp	.L154	#
.L160:
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	xorl	%eax, %eax	#
	movq	%rax, 24(%rsp)	#, %sfp
	movq	%rax, 16(%rsp)	#, %sfp
.L122:
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	xorl	%r14d, %r14d	# _82
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%r15d, %r15d	# _80
# /usr/include/c++/15/bits/stl_vector.h:1122: 	return size_type(__dif);
	xorl	%ebx, %ebx	# _70
.L148:
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movq	%rbx, %rax	# _70, _157
	shrq	%rax	# _157
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	movsd	-8(%r15,%rax,8), %xmm0	# *_160, *_160
	addsd	(%r15,%rbx,4), %xmm0	# *_163, _165
# lab5.cpp:19:     return n & 1 ? values[n / 2] : (values[n / 2 - 1] + values[n / 2]) / 2;
	mulsd	.LC2(%rip), %xmm0	#, _165
	movq	%xmm0, %rbx	# _165, <retval>
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	testq	%r15, %r15	# _80
	je	.L156	#,
	jmp	.L155	#
.L142:
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$1152921504606846975, %rax	#, tmp334
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	16(%rsp), %r13	# %sfp, _99
	subq	24(%rsp), %r13	# %sfp, _99
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%r13, %rdx	# _99, __dif_100
	sarq	$3, %rdx	#, __dif_100
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	cmpq	%rax, %rdx	# tmp334, __dif_100
	je	.L129	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_100
	movl	$1, %eax	#, tmp389
	movsd	%xmm0, 8(%rsp)	# _7, %sfp
	cmovne	%rdx, %rax	# __dif_100,, _102
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_100, __len_103
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$1152921504606846975, %rdx	#, tmp390
	cmpq	%rdx, %rax	# tmp390, __len_103
	cmova	%rdx, %rax	# __len_103,, tmp390, __len_103
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	0(,%rax,8), %r15	#, _120
	movq	%r15, %rdi	# _120,
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	8(%rsp), %xmm0	# %sfp, _7
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r8	#, _121
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	%xmm0, (%rax,%r13)	# _7, *_108
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	testq	%r13, %r13	# _99
	je	.L145	#,
# /usr/include/c++/15/bits/stl_uninitialized.h:1343: 	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rsi	# %sfp,
	movq	%r13, %rdx	# _99,
	movq	%rax, %rdi	# _121,
	call	memcpy@PLT	#
	movq	%rax, %r8	#, _121
.L145:
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	movq	24(%rsp), %rax	# %sfp, samples$_M_start
# /usr/include/c++/15/bits/vector.tcc:601: 	    ++__new_finish;
	leaq	8(%r8,%r13), %r13	#, __new_finish
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%rax, %rax	# samples$_M_start
	je	.L146	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rdi	# samples$_M_start,
	movq	%r8, 8(%rsp)	# _121, %sfp
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%rax, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	movq	8(%rsp), %r8	# %sfp, _121
.L146:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	leaq	(%r8,%r15), %rax	#, samples$_M_end_of_storage
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r8, 24(%rsp)	# _121, %sfp
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%rax, 16(%rsp)	# samples$_M_end_of_storage, %sfp
# /usr/include/c++/15/bits/vector.tcc:647:     }
	jmp	.L141	#
.L196:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rbx	#, tmp253
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movl	$-1, %ebp	#, r
	.p2align 4
	.p2align 3
.L135:
# lab5.cpp:129:             const auto start = Clock::now();
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _289
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r15d, %r15d	# i
# lab5.cpp:129:             const auto start = Clock::now();
	movq	%rax, %r12	#, start
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_289].D.94849._M_impl.D.94184._M_finish, MEM[(const struct vector *)_289].D.94849._M_impl.D.94184._M_finish
	subq	(%rdx), %rax	# MEM[(const struct vector *)_289].D.94849._M_impl.D.94184._M_start, _286
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp251
	imulq	%rbx, %rax	# tmp253, __dif
	jmp	.L125	#
	.p2align 4,,10
	.p2align 3
.L198:
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	24(%r14), %rax	# __closure_18(D)->__edges, __closure_18(D)->__edges
	leaq	(%r15,%r15,2), %rdi	#, _276
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r15	#, i
	salq	$5, %rdi	#, tmp257
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	(%rax), %rsi	# _258->D.94849._M_impl.D.94184._M_start, _256
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	16(%r14), %rax	# __closure_18(D)->__gray, __closure_18(D)->__gray
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%rdi, %rsi	# tmp257, _256
	addq	(%rax), %rdi	# _255->D.94849._M_impl.D.94184._M_start, _253
# lab5.cpp:132:                 if (stage != 0) sobel(gray[i], edges[i]);
	call	_ZL5sobelRKN2cv3MatERS0_	#
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _274
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_274].D.94849._M_impl.D.94184._M_finish, MEM[(const struct vector *)_274].D.94849._M_impl.D.94184._M_finish
	subq	(%rdx), %rax	# MEM[(const struct vector *)_274].D.94849._M_impl.D.94184._M_start, _271
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp266
	imulq	%rbx, %rax	# tmp253, __dif
.L125:
# lab5.cpp:130:             for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r15	# __dif, i
	jb	.L198	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cmpl	$-1, %ebp	#, r
	je	.L126	#,
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT	#
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	movq	8(%r14), %rdx	# __closure_18(D)->__color, _237
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	pxor	%xmm0, %xmm0	# _241
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	pxor	%xmm1, %xmm1	# _222
# /usr/include/c++/15/bits/chrono.h:720: 	return __cd(__cd(__lhs).count() - __cd(__rhs).count());
	subq	%r12, %rax	# start, _244
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	cvtsi2sdq	%rax, %xmm0	# _244, _241
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdx), %rax	# MEM[(const struct vector *)_237].D.94849._M_impl.D.94184._M_finish, MEM[(const struct vector *)_237].D.94849._M_impl.D.94184._M_finish
	subq	(%rdx), %rax	# MEM[(const struct vector *)_237].D.94849._M_impl.D.94184._M_start, _224
# /usr/include/c++/15/bits/chrono.h:218: 	      static_cast<_CR>(__d.count()) / static_cast<_CR>(_CF::den)));
	divsd	.LC0(%rip), %xmm0	#, _238
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp276
	imulq	%rbx, %rax	# tmp253, __dif_223
# lab5.cpp:134:             if (r >= 0) samples.push_back(std::chrono::duration<double, std::milli>(Clock::now() - start).count() / color.size());
	cvtsi2sdq	%rax, %xmm1	# __dif_223, _222
	divsd	%xmm1, %xmm0	# _222, _221
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	%r13, 16(%rsp)	# __new_finish, %sfp
	je	.L199	#,
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	%xmm0, 0(%r13)	# _221, *samples$_M_finish_292
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$8, %r13	#, __new_finish
.L126:
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	movq	(%r14), %rax	# __closure_18(D)->__reps, __closure_18(D)->__reps
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	addl	$1, %ebp	#, r
# lab5.cpp:128:         for (int r = -1; r < reps; ++r) { // one warm-up; then median of measured runs
	cmpl	%ebp, (%rax)	# r, *_98
	jg	.L135	#,
	jmp	.L136	#
.L199:
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$1152921504606846975, %rdx	#, tmp281
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	16(%rsp), %r13	# %sfp, _195
	subq	24(%rsp), %r13	# %sfp, _195
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%r13, %rax	# _195, __dif_194
	sarq	$3, %rax	#, __dif_194
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	cmpq	%rdx, %rax	# tmp281, __dif_194
	je	.L129	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rax, %rax	# __dif_194
	movl	$1, %r12d	#, tmp391
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movsd	%xmm0, 8(%rsp)	# _221, %sfp
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	cmovne	%rax, %r12	# __dif_194,, _187
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %r12	# __dif_194, __len_179
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %r12	# tmp281, __len_179
	cmova	%rdx, %r12	# __len_179,, tmp281, __len_179
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	salq	$3, %r12	#, _170
	movq	%r12, %rdi	# _170,
	call	_Znwm@PLT	#
.LEHE0:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	8(%rsp), %xmm0	# %sfp, _221
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r15	#, _168
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movsd	%xmm0, (%rax,%r13)	# _221, *_149
# /usr/include/c++/15/bits/stl_uninitialized.h:1331:       if (__count > 0)
	testq	%r13, %r13	# _195
	jne	.L130	#,
.L134:
# /usr/include/c++/15/bits/vector.tcc:601: 	    ++__new_finish;
	leaq	8(%r15,%r13), %r13	#, __new_finish
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	cmpq	$0, 24(%rsp)	#, %sfp
	je	.L133	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L133:
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	leaq	(%r15,%r12), %rax	#, samples$_M_end_of_storage
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r15, 24(%rsp)	# _168, %sfp
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%rax, 16(%rsp)	# samples$_M_end_of_storage, %sfp
	jmp	.L126	#
.L130:
# /usr/include/c++/15/bits/stl_uninitialized.h:1343: 	  __builtin_memcpy(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rsi	# %sfp,
	movq	%r13, %rdx	# _195,
	movq	%rax, %rdi	# _168,
	call	memcpy@PLT	#
	jmp	.L134	#
.L193:
	endbr64	
	jmp	.L194	#
	.section	.gcc_except_table,"a",@progbits
.LLSDA10502:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE10502-.LLSDACSB10502
.LLSDACSB10502:
	.uleb128 .LEHB0-.LFB10502
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L193-.LFB10502
	.uleb128 0
.LLSDACSE10502:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC10502
	.type	_ZZ4mainENKUliE_clEi.cold, @function
_ZZ4mainENKUliE_clEi.cold:
.LFSB10502:
.L129:
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
.L162:
	endbr64	
.L194:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	movq	%rax, %rbx	#, tmp387
	cmpq	$0, 24(%rsp)	#, %sfp
	je	.L159	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rsp), %rsi	# %sfp, samples$_M_end_of_storage
	movq	24(%rsp), %rdi	# %sfp, samples$_M_start
	subq	%rdi, %rsi	# samples$_M_start, samples$_M_end_of_storage
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L159:
	movq	%rbx, %rdi	# tmp387,
.LEHB2:
	call	_Unwind_Resume@PLT	#
.LEHE2:
	.cfi_endproc
.LFE10502:
	.section	.gcc_except_table
.LLSDAC10502:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC10502-.LLSDACSBC10502
.LLSDACSBC10502:
	.uleb128 .LEHB1-.LCOLDB3
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L162-.LCOLDB3
	.uleb128 0
	.uleb128 .LEHB2-.LCOLDB3
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSEC10502:
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
.LFB11672:
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
	movq	8(%rdi), %rbp	# this_3(D)->D.94849._M_impl.D.94184._M_finish, _1
# /usr/include/c++/15/bits/stl_vector.h:802: 	std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	(%rdi), %rbx	# this_3(D)->D.94849._M_impl.D.94184._M_start, __first
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _1
	je	.L201	#,
	.p2align 4
	.p2align 3
.L202:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _1
	jne	.L202	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%r12), %rbx	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_start, __first
.L201:
# /usr/include/c++/15/bits/stl_vector.h:395: 	if (__p)
	testq	%rbx, %rbx	# __first
	je	.L200	#,
# /usr/include/c++/15/bits/stl_vector.h:376: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%r12), %rsi	# MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_end_of_storage, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_end_of_storage
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
.L200:
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
.LFE11672:
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
.LFB11686:
	.cfi_startproc
	endbr64	
# /usr/include/c++/15/bits/stl_vector.h:2215: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	movabsq	$96076792050570581, %rax	#, tmp110
# /usr/include/c++/15/bits/stl_vector.h:586:       vector(size_type __n, const allocator_type& __a = allocator_type())
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
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
	jb	.L213	#,
	movq	%rdi, %r12	# this, this
	movq	%rsi, %rbx	# __n, __n
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%rsi, %rsi	# __n
	je	.L214	#,
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rsi,%rsi,2), %r13	#, _29
	salq	$5, %r13	#, tmp115
	movq	%r13, %rdi	# tmp115,
	call	_Znwm@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	addq	%rax, %r13	# _30, _1
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	movq	%rax, %xmm0	# _30, _33
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rax, %rbp	# _30, __first
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%r13, 16(%r12)	# _1, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	punpcklqdq	%xmm0, %xmm0	# _33
	movups	%xmm0, (%r12)	# _33, MEM <vector(2) long unsigned int> [(struct Mat * *)this_3(D)]
	.p2align 4
	.p2align 3
.L210:
# /usr/include/c++/15/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movq	%rbp, %rdi	# __first,
# /usr/include/c++/15/bits/stl_uninitialized.h:875: 	  for (; __n > 0; --__n, (void) ++__first)
	addq	$96, %rbp	#, __first
# /usr/include/c++/15/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	call	_ZN2cv3MatC1Ev@PLT	#
# /usr/include/c++/15/bits/stl_uninitialized.h:875: 	  for (; __n > 0; --__n, (void) ++__first)
	subq	$1, %rbx	#, __n
	jne	.L210	#,
	movq	%r13, %rax	# _1, _1
# /usr/include/c++/15/bits/stl_vector.h:2010: 	this->_M_impl._M_finish =
	movq	%rax, 8(%r12)	# _1, *this_3(D).D.94849._M_impl.D.94184._M_finish
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
.L214:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_vector.h:387: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%eax, %eax	# _1
# /usr/include/c++/15/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	movq	$0, (%rdi)	#, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_start
# /usr/include/c++/15/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	$0, 16(%rdi)	#, MEM[(struct _Vector_base *)this_3(D)]._M_impl.D.94184._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:2010: 	this->_M_impl._M_finish =
	movq	%rax, 8(%r12)	# _1, *this_3(D).D.94849._M_impl.D.94184._M_finish
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
.L213:
	.cfi_restore_state
# /usr/include/c++/15/bits/stl_vector.h:2216: 	  __throw_length_error(
	leaq	.LC4(%rip), %rdi	#,
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE11686:
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_, .-_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_
	.set	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_,_ZNSt6vectorIN2cv3MatESaIS1_EEC2EmRKS2_
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_, @function
_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_:
.LFB12585:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA12585
	endbr64	
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp125
# /usr/include/c++/15/bits/vector.tcc:557:       vector<_Tp, _Alloc>::
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
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_9(D)].D.94849._M_impl.D.94184._M_finish, _15
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rdi), %r13	# MEM[(const struct vector *)this_9(D)].D.94849._M_impl.D.94184._M_start, _16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbp, %rbx	# _15, _17
	subq	%r13, %rbx	# _16, _17
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbx, %rdx	# _17, tmp123
	sarq	$5, %rdx	#, tmp123
	imulq	%rax, %rdx	# tmp125, __dif_18
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$96076792050570581, %rax	#, tmp126
	cmpq	%rax, %rdx	# tmp126, __dif_18
	je	.L237	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_18
	movl	$1, %eax	#, tmp149
	movq	%rdi, %r14	# this, this
	movq	%rsi, 16(%rsp)	# __args#0, %sfp
	cmovne	%rdx, %rax	# __dif_18,, _20
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_18, __len_21
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$96076792050570581, %rdx	#, tmp150
	cmpq	%rdx, %rax	# tmp150, __len_21
	cmova	%rdx, %rax	# __len_21,, tmp150, __len_21
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rax,%rax,2), %r15	#, _47
	salq	$5, %r15	#, _47
	movq	%r15, %rdi	# _47, tmp133
	movq	%r15, 8(%rsp)	# tmp133, %sfp
.LEHB3:
	call	_Znwm@PLT	#
.LEHE3:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	16(%rsp), %rsi	# %sfp, __args#0
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	leaq	(%rax,%rbx), %rdi	#, _2
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	#, _48
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	movq	%rdi, 24(%rsp)	# _2, %sfp
.LEHB4:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE4:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r13, %rbp	# _16, _15
	je	.L217	#,
	movq	%r12, %rbx	# _48, __result
	movq	%r13, %r15	# _16, __first
	jmp	.L221	#
	.p2align 4,,10
	.p2align 3
.L227:
	addq	$96, %rbx	#, __result
.L221:
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
	jne	.L227	#,
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	192(%rbx), %r15	#, __new_finish
	movq	%r13, %rbx	# _16, __first
	.p2align 4
	.p2align 3
.L222:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _15
	jne	.L222	#,
.L226:
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%r13, %r13	# _16
	je	.L225	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%r14), %rsi	# this_9(D)->D.94849._M_impl.D.94184._M_end_of_storage, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _16,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%r13, %rsi	# _16, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L225:
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r12, (%r14)	# _48, this_9(D)->D.94849._M_impl.D.94184._M_start
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	8(%rsp), %r12	# %sfp, tmp143
# /usr/include/c++/15/bits/vector.tcc:645:       this->_M_impl._M_finish = __new_finish;
	movq	%r15, 8(%r14)	# __new_finish, this_9(D)->D.94849._M_impl.D.94184._M_finish
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%r12, 16(%r14)	# tmp143, this_9(D)->D.94849._M_impl.D.94184._M_end_of_storage
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
.L217:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	96(%r12), %r15	#, __new_finish
	jmp	.L226	#
.L229:
	endbr64	
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%rax, %rbp	#, tmp147
	jmp	.L219	#
.L228:
	endbr64	
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rbp	# tmp148, tmp139
	jmp	.L224	#
.L237:
# /usr/include/c++/15/bits/stl_vector.h:2205: 	  __throw_length_error(__N(__s));
	leaq	.LC1(%rip), %rdi	#,
.LEHB6:
	call	_ZSt20__throw_length_errorPKc@PLT	#
.L219:
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%r12, %r13	# _48, __first
.L220:
	cmpq	%rbx, %r13	# __result, __first
	je	.L238	#,
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%r13, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %r13	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
	jmp	.L220	#
.L238:
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZN2cv3MatD1Ev@PLT	#
.L224:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	8(%rsp), %rsi	# %sfp,
	movq	%r12, %rdi	# _48,
	call	_ZdlPvm@PLT	#
	movq	%rbp, %rdi	# tmp139,
	call	_Unwind_Resume@PLT	#
.LEHE6:
	.cfi_endproc
.LFE12585:
	.section	.gcc_except_table
.LLSDA12585:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE12585-.LLSDACSB12585
.LLSDACSB12585:
	.uleb128 .LEHB3-.LFB12585
	.uleb128 .LEHE3-.LEHB3
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB4-.LFB12585
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L228-.LFB12585
	.uleb128 0
	.uleb128 .LEHB5-.LFB12585
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L229-.LFB12585
	.uleb128 0
	.uleb128 .LEHB6-.LFB12585
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE12585:
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_,comdat
	.size	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_, .-_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_
	.section	.text._ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,"axG",@progbits,_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_
	.type	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_, @function
_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_:
.LFB13416:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA13416
	endbr64	
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp125
# /usr/include/c++/15/bits/vector.tcc:557:       vector<_Tp, _Alloc>::
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
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_9(D)].D.94849._M_impl.D.94184._M_finish, _15
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	(%rdi), %r13	# MEM[(const struct vector *)this_9(D)].D.94849._M_impl.D.94184._M_start, _16
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbp, %rbx	# _15, _17
	subq	%r13, %rbx	# _16, _17
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rbx, %rdx	# _17, tmp123
	sarq	$5, %rdx	#, tmp123
	imulq	%rax, %rdx	# tmp125, __dif_18
# /usr/include/c++/15/bits/stl_vector.h:2204: 	if (max_size() - size() < __n)
	movabsq	$96076792050570581, %rax	#, tmp126
	cmpq	%rax, %rdx	# tmp126, __dif_18
	je	.L261	#,
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	testq	%rdx, %rdx	# __dif_18
	movl	$1, %eax	#, tmp149
	movq	%rdi, %r14	# this, this
	movq	%rsi, 16(%rsp)	# __args#0, %sfp
	cmovne	%rdx, %rax	# __dif_18,, _20
# /usr/include/c++/15/bits/stl_vector.h:2207: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rdx, %rax	# __dif_18, __len_21
# /usr/include/c++/15/bits/stl_vector.h:2208: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$96076792050570581, %rdx	#, tmp150
	cmpq	%rdx, %rax	# tmp150, __len_21
	cmova	%rdx, %rax	# __len_21,, tmp150, __len_21
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rax,%rax,2), %r15	#, _47
	salq	$5, %r15	#, _47
	movq	%r15, %rdi	# _47, tmp133
	movq	%r15, 8(%rsp)	# tmp133, %sfp
.LEHB7:
	call	_Znwm@PLT	#
.LEHE7:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	16(%rsp), %rsi	# %sfp, __args#0
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	leaq	(%rax,%rbx), %rdi	#, _2
# /usr/include/c++/15/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	#, _48
# /usr/include/c++/15/bits/vector.tcc:586: 	_Alloc_traits::construct(this->_M_impl,
	movq	%rdi, 24(%rsp)	# _2, %sfp
.LEHB8:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1EOS0_@PLT	#
.LEHE8:
# /usr/include/c++/15/bits/stl_uninitialized.h:144:       for (; __first != __last; ++__first, (void)++__result)
	cmpq	%r13, %rbp	# _16, _15
	je	.L241	#,
	movq	%r12, %rbx	# _48, __result
	movq	%r13, %r15	# _16, __first
	jmp	.L245	#
	.p2align 4,,10
	.p2align 3
.L251:
	addq	$96, %rbx	#, __result
.L245:
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
	jne	.L251	#,
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	192(%rbx), %r15	#, __new_finish
	movq	%r13, %rbx	# _16, __first
	.p2align 4
	.p2align 3
.L246:
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %rbx	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	cmpq	%rbx, %rbp	# __first, _15
	jne	.L246	#,
.L250:
# /usr/include/c++/15/bits/stl_vector.h:1882: 	  if (_M_storage)
	testq	%r13, %r13	# _16
	je	.L249	#,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	movq	16(%r14), %rsi	# this_9(D)->D.94849._M_impl.D.94184._M_end_of_storage, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _16,
# /usr/include/c++/15/bits/vector.tcc:639: 	__guard._M_len = this->_M_impl._M_end_of_storage - __old_start;
	subq	%r13, %rsi	# _16, _4
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L249:
# /usr/include/c++/15/bits/vector.tcc:644:       this->_M_impl._M_start = __new_start;
	movq	%r12, (%r14)	# _48, this_9(D)->D.94849._M_impl.D.94184._M_start
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	8(%rsp), %r12	# %sfp, tmp143
# /usr/include/c++/15/bits/vector.tcc:645:       this->_M_impl._M_finish = __new_finish;
	movq	%r15, 8(%r14)	# __new_finish, this_9(D)->D.94849._M_impl.D.94184._M_finish
# /usr/include/c++/15/bits/vector.tcc:646:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%r12, 16(%r14)	# tmp143, this_9(D)->D.94849._M_impl.D.94184._M_end_of_storage
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
.L241:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:632: 	    ++__new_finish;
	leaq	96(%r12), %r15	#, __new_finish
	jmp	.L250	#
.L253:
	endbr64	
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%rax, %rbp	#, tmp147
	jmp	.L243	#
.L252:
	endbr64	
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rax, %rbp	# tmp148, tmp139
	jmp	.L248	#
.L261:
# /usr/include/c++/15/bits/stl_vector.h:2205: 	  __throw_length_error(__N(__s));
	leaq	.LC1(%rip), %rdi	#,
.LEHB10:
	call	_ZSt20__throw_length_errorPKc@PLT	#
.L243:
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	movq	%r12, %r13	# _48, __first
.L244:
	cmpq	%rbx, %r13	# __result, __first
	je	.L262	#,
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	movq	%r13, %rdi	# __first,
# /usr/include/c++/15/bits/stl_construct.h:225: 	for (; __first != __last; ++__first)
	addq	$96, %r13	#, __first
# /usr/include/c++/15/bits/stl_construct.h:166:       __pointer->~_Tp();
	call	_ZN2cv3MatD1Ev@PLT	#
	jmp	.L244	#
.L262:
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZN2cv3MatD1Ev@PLT	#
.L248:
# /usr/include/c++/15/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	8(%rsp), %rsi	# %sfp,
	movq	%r12, %rdi	# _48,
	call	_ZdlPvm@PLT	#
	movq	%rbp, %rdi	# tmp139,
	call	_Unwind_Resume@PLT	#
.LEHE10:
	.cfi_endproc
.LFE13416:
	.section	.gcc_except_table
.LLSDA13416:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE13416-.LLSDACSB13416
.LLSDACSB13416:
	.uleb128 .LEHB7-.LFB13416
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LFB13416
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L252-.LFB13416
	.uleb128 0
	.uleb128 .LEHB9-.LFB13416
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L253-.LFB13416
	.uleb128 0
	.uleb128 .LEHB10-.LFB13416
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSE13416:
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
.LFB10501:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA10501
	endbr64	
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
	subq	$456, %rsp	#,
	.cfi_def_cfa_offset 512
# lab5.cpp:115: int main(int argc, char** argv) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp204
	movq	%rax, 440(%rsp)	# tmp204, D.374312
	xorl	%eax, %eax	# tmp204
# lab5.cpp:116:     const std::string video = argc > 1 ? argv[1] : "";
	cmpl	$1, %edi	#, argc
	jle	.L317	#,
# lab5.cpp:116:     const std::string video = argc > 1 ? argv[1] : "";
	movq	8(%rsi), %r14	# MEM[(char * *)argv_23(D) + 8B], iftmp.0_24
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	leaq	208(%rsp), %rax	#, tmp389
	leaq	224(%rsp), %rbx	#, _133
	movq	%rsi, %r12	# argv, argv
	movq	%rax, 24(%rsp)	# tmp389, %sfp
	movq	%rbx, 208(%rsp)	# _133, MEM[(struct _Alloc_hider *)&video]._M_p
# /usr/include/c++/15/bits/basic_string.h:710: 	if (__s == 0)
	testq	%r14, %r14	# iftmp.0_24
	je	.L313	#,
	movl	%edi, %ebp	# argc, argc
# /usr/include/c++/15/bits/char_traits.h:393: 	return __builtin_strlen(__s);
	movq	%r14, %rdi	# iftmp.0_24,
	call	strlen@PLT	#
# /usr/include/c++/15/bits/basic_string.tcc:231: 	size_type __dnew = static_cast<size_type>(std::distance(__beg, __end));
	movq	%rax, 160(%rsp)	# tmp401, MEM[(long unsigned int *)_316]
# /usr/include/c++/15/bits/char_traits.h:393: 	return __builtin_strlen(__s);
	movq	%rax, %r13	#, tmp401
# /usr/include/c++/15/bits/basic_string.tcc:233: 	if (__dnew > size_type(_S_local_capacity))
	cmpq	$15, %rax	#, tmp401
	jbe	.L268	#,
# /usr/include/c++/15/bits/basic_string.tcc:235: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	24(%rsp), %rdi	# %sfp,
	leaq	160(%rsp), %rsi	#, tmp216
	xorl	%edx, %edx	#
.LEHB11:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT	#
.LEHE11:
# /usr/include/c++/15/bits/basic_string.h:229:       { _M_dataplus._M_p = __p; }
	movq	%rax, 208(%rsp)	# _133, video._M_dataplus._M_p
# /usr/include/c++/15/bits/basic_string.tcc:235: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	%rax, %rdi	# _133, _133
# /usr/include/c++/15/bits/basic_string.h:266:       { _M_allocated_capacity = __capacity; }
	movq	160(%rsp), %rax	# MEM[(long unsigned int *)_316], MEM[(long unsigned int *)_316]
	movq	%rax, 224(%rsp)	# MEM[(long unsigned int *)_316], video.D.35376._M_allocated_capacity
.L269:
# /usr/include/c++/15/bits/char_traits.h:429: 	return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
	movq	%r13, %rdx	# tmp401,
	movq	%r14, %rsi	# iftmp.0_24,
	call	memcpy@PLT	#
.L271:
# /usr/include/c++/15/bits/basic_string.tcc:257: 	_M_set_length(__dnew);
	movq	160(%rsp), %rax	# MEM[(long unsigned int *)_316], __dnew.6_142
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movq	208(%rsp), %rdx	# video._M_dataplus._M_p, video._M_dataplus._M_p
# /usr/include/c++/15/bits/basic_string.h:234:       { _M_string_length = __length; }
	movq	%rax, 216(%rsp)	# __dnew.6_142, video._M_string_length
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	$0, (%rdx,%rax)	#, MEM[(char_type &)_144]
# lab5.cpp:117:     const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
	cmpl	$2, %ebp	#, argc
	je	.L265	#,
# /usr/include/stdlib.h:487:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	16(%r12), %rdi	# MEM[(char * *)argv_23(D) + 16B], MEM[(char * *)argv_23(D) + 16B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	movl	$1, %edx	#, tmp424
	testl	%eax, %eax	# _76
	cmovg	%eax, %edx	# _76,, tmp424
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	$7, %eax	#, iftmp.1_14
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	movl	%edx, %r14d	# tmp424, frameCount
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	cmpl	$3, %ebp	#, argc
	jne	.L318	#,
.L273:
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	pxor	%xmm0, %xmm0	# tmp227
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	%eax, 36(%rsp)	# iftmp.1_14, reps
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 80(%rsp)	#, MEM[(struct _Vector_impl_data *)&color]._M_end_of_storage
# /usr/include/c++/15/bits/stl_vector.h:106: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movaps	%xmm0, 64(%rsp)	# tmp227, MEM <vector(2) long unsigned int> [(struct Mat * *)&color]
# lab5.cpp:98:     if (!path.empty()) {
	cmpq	$0, 216(%rsp)	#, video._M_string_length
	jne	.L274	#,
	leaq	64(%rsp), %rax	#, tmp392
	movq	%rax, (%rsp)	# tmp392, %sfp
.L283:
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	leaq	56(%rsp), %rax	#, tmp395
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	.LC8(%rip), %r15	#, tmp396
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	xorl	%r13d, %r13d	# i
# /usr/include/opencv4/opencv2/core/operations.hpp:395: inline RNG::RNG(uint64 _state) { state = _state ? _state : 0xffffffff; }
	movq	$442, 40(%rsp)	#, rng.state
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, 8(%rsp)	# tmp395, %sfp
	leaq	48(%rsp), %rax	#, tmp397
	leaq	336(%rsp), %rbx	#, tmp387
	movq	%rax, 16(%rsp)	# tmp397, %sfp
	jmp	.L275	#
	.p2align 4,,10
	.p2align 3
.L320:
.LEHB12:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1ERKS0_@PLT	#
.LEHE12:
# /usr/include/c++/15/bits/stl_vector.h:1423: 	    ++this->_M_impl._M_finish;
	addq	$96, 72(%rsp)	#, color.D.94849._M_impl.D.94184._M_finish
.L286:
# lab5.cpp:110:         }
	movq	%rbx, %rdi	# tmp387,
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	addl	$1, %r13d	#, i
# lab5.cpp:110:         }
	call	_ZN2cv3MatD1Ev@PLT	#
# lab5.cpp:106:         for (int i = 0; i < count; ++i) {
	cmpl	%r13d, %r14d	# i, frameCount
	je	.L319	#,
.L275:
# lab5.cpp:107:             cv::Mat frame(720, 1280, CV_8UC3);
	movl	$16, %ecx	#,
	movl	$1280, %edx	#,
	movl	$720, %esi	#,
	movq	%rbx, %rdi	# tmp387,
.LEHB13:
	call	_ZN2cv3MatC1Eiii@PLT	#
.LEHE13:
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	leaq	96(%rsp), %r12	#, tmp385
	leaq	40(%rsp), %rdi	#, tmp265
	xorl	%r9d, %r9d	#
	xorl	%edx, %edx	#
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	.LC7(%rip), %rax	#, tmp439
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	leaq	160(%rsp), %rbp	#, tmp388
	movq	%r12, %rsi	# tmp385,
	leaq	128(%rsp), %rcx	#, tmp263
	movq	%rbp, %r8	# tmp388,
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movq	%rbx, 104(%rsp)	# tmp387, MEM[(struct _InputArray *)_203].obj
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	%rax, 56(%rsp)	# tmp439, D.374209
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	8(%rsp), %rax	# %sfp, tmp395
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movl	$-1056833530, 160(%rsp)	#, MEM[(struct _InputArray *)_316].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, 168(%rsp)	# tmp395, MEM[(struct _InputArray *)_316].obj
	movq	16(%rsp), %rax	# %sfp, tmp397
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%r15, 176(%rsp)	# tmp396, MEM <vector(2) int> [(struct _InputArray *)_316 + 16B]
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	movq	$0x000000000, 48(%rsp)	#, D.374207
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movl	$-1056833530, 128(%rsp)	#, MEM[(struct _InputArray *)_202].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%rax, 136(%rsp)	# tmp397, MEM[(struct _InputArray *)_202].obj
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:95: { flags = _flags; obj = (void*)_obj; sz = _sz; }
	movq	%r15, 144(%rsp)	# tmp396, MEM <vector(2) int> [(struct _InputArray *)_202 + 16B]
# /usr/include/opencv4/opencv2/core/types.hpp:1686:     : width(0), height(0) {}
	movq	$0, 112(%rsp)	#, MEM <vector(2) int> [(int *)_203 + 16B]
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movl	$50397184, 96(%rsp)	#, MEM[(struct _InputArray *)_203].flags
.LEHB14:
# lab5.cpp:108:             rng.fill(frame, cv::RNG::UNIFORM, 0, 256);
	call	_ZN2cv3RNG4fillERKNS_17_InputOutputArrayEiRKNS_11_InputArrayES6_b@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1418: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	72(%rsp), %rdi	# color.D.94849._M_impl.D.94184._M_finish, _174
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	%rbx, %rsi	# tmp387,
# /usr/include/c++/15/bits/stl_vector.h:1418: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	80(%rsp), %rdi	# color.D.94849._M_impl.D.94184._M_end_of_storage, _174
	jne	.L320	#,
# /usr/include/c++/15/bits/stl_vector.h:1427: 	  _M_realloc_append(__x);
	movq	(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJRKS1_EEEvDpOT_	#
.LEHE14:
	jmp	.L286	#
.L268:
# /usr/include/c++/15/bits/basic_string.h:450: 	if (__n == 1)
	cmpq	$1, %rax	#, tmp401
	jne	.L270	#,
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movzbl	(%r14), %eax	# MEM[(const char_type &)iftmp.0_24], _141
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	%al, 224(%rsp)	# _141, MEM[(char_type &)&video + 16]
# /usr/include/c++/15/bits/char_traits.h:353:       }
	jmp	.L271	#
.L317:
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	leaq	224(%rsp), %rax	#, tmp207
# /usr/include/c++/15/bits/char_traits.h:352: 	__c1 = __c2;
	movb	$0, 224(%rsp)	#, MEM[(char_type &)_197]
# /usr/include/c++/15/bits/basic_string.h:205: 	: allocator_type(__a), _M_p(__dat) { }
	movq	%rax, 208(%rsp)	# tmp207, MEM[(struct _Alloc_hider *)&video]._M_p
# /usr/include/c++/15/bits/basic_string.h:234:       { _M_string_length = __length; }
	xorl	%eax, %eax	#
	movq	%rax, 160(%rsp)	#, MEM[(long unsigned int *)_316]
	movq	%rax, 216(%rsp)	#, video._M_string_length
	leaq	208(%rsp), %rax	#, tmp389
	movq	%rax, 24(%rsp)	# tmp389, %sfp
.L265:
# lab5.cpp:117:     const int frameCount = argc > 2 ? std::max(1, std::atoi(argv[2])) : 30;
	movl	$30, %r14d	#, frameCount
# lab5.cpp:118:     const int reps = argc > 3 ? std::max(3, std::atoi(argv[3])) : 7;
	movl	$7, %eax	#, iftmp.1_14
	jmp	.L273	#
.L274:
# lab5.cpp:99:         cv::VideoCapture video(path);
	leaq	160(%rsp), %rbp	#, tmp388
	movq	24(%rsp), %rsi	# %sfp,
	leaq	64(%rsp), %rax	#, tmp392
	xorl	%edx, %edx	#
	movq	%rbp, %rdi	# tmp388,
	movq	%rax, (%rsp)	# tmp392, %sfp
.LEHB15:
	call	_ZN2cv12VideoCaptureC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi@PLT	#
.LEHE15:
# lab5.cpp:100:         cv::Mat frame;
	leaq	240(%rsp), %r12	#, tmp391
	leaq	64(%rsp), %rbx	#, tmp392
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %r13	#, tmp234
# lab5.cpp:100:         cv::Mat frame;
	movq	%r12, %rdi	# tmp391,
	call	_ZN2cv3MatC1Ev@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rdx	# color.D.94849._M_impl.D.94184._M_finish, _147
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	64(%rsp), %rcx	# color.D.94849._M_impl.D.94184._M_start, _148
	movq	%rbx, (%rsp)	# tmp392, %sfp
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rdx, %rax	# _147, _13
	subq	%rcx, %rax	# _148, _13
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp232
	imulq	%r13, %rax	# tmp234, __dif
	jmp	.L276	#
	.p2align 4,,10
	.p2align 3
.L322:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	leaq	128(%rsp), %rsi	#, tmp247
	movq	%rbp, %rdi	# tmp388,
# /usr/include/opencv4/opencv2/core/types.hpp:1686:     : width(0), height(0) {}
	movq	$0, 144(%rsp)	#, MEM <vector(2) int> [(int *)_202 + 16B]
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movl	$33619968, 128(%rsp)	#, MEM[(struct _InputArray *)_202].flags
# /usr/include/opencv4/opencv2/core/mat.inl.hpp:92: { flags = _flags; obj = (void*)_obj; }
	movq	%r12, 136(%rsp)	# tmp391, MEM[(struct _InputArray *)_202].obj
.LEHB16:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	call	_ZN2cv12VideoCapture4readERKNS_12_OutputArrayE@PLT	#
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	testb	%al, %al	# _152
	je	.L321	#,
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	leaq	336(%rsp), %rbx	#, tmp387
	movq	%r12, %rsi	# tmp391,
	movq	%rbx, %rdi	# tmp387,
	call	_ZNK2cv3Mat5cloneEv@PLT	#
.LEHE16:
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	72(%rsp), %rdi	# color.D.94849._M_impl.D.94184._M_finish, _160
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	%rbx, %rsi	# tmp387,
# /usr/include/c++/15/bits/vector.tcc:114: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	80(%rsp), %rdi	# color.D.94849._M_impl.D.94184._M_end_of_storage, _160
	je	.L277	#,
.LEHB17:
# /usr/include/c++/15/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	_ZN2cv3MatC1EOS0_@PLT	#
.LEHE17:
# /usr/include/c++/15/bits/vector.tcc:119: 	    ++this->_M_impl._M_finish;
	addq	$96, 72(%rsp)	#, color.D.94849._M_impl.D.94184._M_finish
.L278:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	movq	%rbx, %rdi	# tmp387,
	call	_ZN2cv3MatD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rdx	# color.D.94849._M_impl.D.94184._M_finish, _147
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	64(%rsp), %rcx	# color.D.94849._M_impl.D.94184._M_start, _148
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	%rdx, %rax	# _147, _149
	subq	%rcx, %rax	# _148, _149
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp242
	imulq	%r13, %rax	# tmp234, __dif
.L276:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	cmpl	%eax, %r14d	# __dif, frameCount
	jg	.L322	#,
.L280:
# lab5.cpp:102:         if (frames.empty()) std::cerr << "Could not read video; using deterministic synthetic frames.\n";
	cmpq	%rdx, %rcx	# _147, _148
	je	.L323	#,
.L282:
# lab5.cpp:103:     }
	movq	%r12, %rdi	# tmp391,
	call	_ZN2cv3MatD1Ev@PLT	#
# lab5.cpp:103:     }
	movq	%rbp, %rdi	# tmp388,
	call	_ZN2cv12VideoCaptureD1Ev@PLT	#
# /usr/include/c++/15/bits/stl_iterator.h:1059:       : _M_current(__i) { }
	movq	72(%rsp), %rsi	# MEM[(const struct Mat * const &)&color + 8], _156
	movq	64(%rsp), %rax	# MEM[(const struct Mat * const &)&color], _157
# lab5.cpp:104:     if (frames.empty()) {
	cmpq	%rax, %rsi	# _157, _156
	je	.L283	#,
	leaq	96(%rsp), %r12	#, tmp385
.L284:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rax, %rsi	# _157, _69
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	movq	%rbp, %rdx	# tmp388,
	movq	%r12, %rdi	# tmp385,
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp275
	sarq	$5, %rsi	#, tmp273
	imulq	%rax, %rsi	# tmp275, __dif_39
.LEHB18:
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	call	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_	#
.LEHE18:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rsi	# color.D.94849._M_impl.D.94184._M_finish, color.D.94849._M_impl.D.94184._M_finish
	subq	64(%rsp), %rsi	# color.D.94849._M_impl.D.94184._M_start, _32
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	leaq	128(%rsp), %rbx	#, tmp386
	movq	%rbp, %rdx	# tmp388,
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rsi	#, tmp298
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	movq	%rbx, %rdi	# tmp386,
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp300
	imulq	%rax, %rsi	# tmp300, __dif_31
.LEHB19:
# lab5.cpp:120:     std::vector<cv::Mat> gray(color.size()), edges(color.size());
	call	_ZNSt6vectorIN2cv3MatESaIS1_EEC1EmRKS2_	#
.LEHE19:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	64(%rsp), %rdx	# color.D.94849._M_impl.D.94184._M_start, _92
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_finish, _190
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	xorl	%r15d, %r15d	# i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %r13	#, tmp306
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rdx, %rax	# _92, _190
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp304
	imulq	%r13, %rax	# tmp306, __dif
	jmp	.L293	#
	.p2align 4,,10
	.p2align 3
.L294:
	leaq	(%r15,%r15,2), %r14	#, _44
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	96(%rsp), %rdi	# MEM[(struct vector *)_203].D.94849._M_impl.D.94184._M_start, _86
# lab5.cpp:122:         gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
	xorl	%ecx, %ecx	#
	salq	$5, %r14	#, tmp310
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	addq	%r14, %rdx	# tmp310, _83
	addq	%r14, %rdi	# tmp310, _86
# lab5.cpp:122:         gray[i].create(color[i].rows, color[i].cols, CV_8UC1);
	movl	12(%rdx), %eax	# _83->cols, _83->cols
	movl	8(%rdx), %esi	# _83->rows, _83->rows
	movl	%eax, %edx	# _83->cols,
.LEHB20:
	call	_ZN2cv3Mat6createEiii@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1264: 	return *(this->_M_impl._M_start + __n);
	movq	64(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_start, _88
	movq	128(%rsp), %rdi	# MEM[(struct vector *)_202].D.94849._M_impl.D.94184._M_start, tmp310
	addq	%r14, %rax	# tmp310, _88
	addq	%r14, %rdi	# tmp310, tmp310
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	movl	12(%rax), %ecx	# _88->cols, tmp445
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	movl	8(%rax), %esi	# _88->rows, _88->rows
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	leal	-2(%rcx), %edx	#, _6
# lab5.cpp:123:         edges[i].create(color[i].rows - 2, color[i].cols - 2, CV_8UC1);
	subl	$2, %esi	#, _8
	xorl	%ecx, %ecx	#
	call	_ZN2cv3Mat6createEiii@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	64(%rsp), %rdx	# color.D.94849._M_impl.D.94184._M_start, _92
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_finish, _93
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	addq	$1, %r15	#, i
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	subq	%rdx, %rax	# _92, _93
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rax	#, tmp324
	imulq	%r13, %rax	# tmp306, __dif
.L293:
# lab5.cpp:121:     for (size_t i = 0; i < color.size(); ++i) {
	cmpq	%rax, %r15	# __dif, i
	jb	.L294	#,
# lab5.cpp:137:     };
	leaq	36(%rsp), %rax	#, _323
	movq	%rbx, %xmm1	# tmp386, tmp386
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# tmp388,
# lab5.cpp:137:     };
	movq	%rax, %xmm0	# _323, _323
	movhps	(%rsp), %xmm0	# %sfp, _324
	movaps	%xmm0, 160(%rsp)	# _324, MEM <vector(2) long unsigned int> [(void *)_316]
	movq	%r12, %xmm0	# tmp385, _321
	punpcklqdq	%xmm1, %xmm0	# tmp386, _321
	movaps	%xmm0, 176(%rsp)	# _321, MEM <vector(2) long unsigned int> [(void *)_316 + 16B]
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	call	_ZZ4mainENKUliE_clEi	#
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movl	$1, %esi	#,
	movq	%rbp, %rdi	# tmp388,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movq	%xmm0, %r13	#, _46
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	call	_ZZ4mainENKUliE_clEi	#
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movl	$2, %esi	#,
	movq	%rbp, %rdi	# tmp388,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movq	%xmm0, %r14	#, _48
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	call	_ZZ4mainENKUliE_clEi	#
# /usr/include/c++/15/bits/ostream.h:140: 	__pf(*this);
	movq	_ZSt4cout(%rip), %rax	# cout._vptr.basic_ostream, cout._vptr.basic_ostream
	leaq	_ZSt4cout(%rip), %rdx	#, _99
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	leaq	.LC10(%rip), %rsi	#,
# lab5.cpp:139:     const double grayMs = measure(0), sobelMs = measure(1), totalMs = measure(2);
	movq	%xmm0, %r15	#, _50
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	leaq	_ZSt4cout(%rip), %rdi	#,
# /usr/include/c++/15/bits/ostream.h:140: 	__pf(*this);
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
	movl	$41, %edx	#,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
	movl	$8, %edx	#,
	leaq	.LC11(%rip), %rsi	#,
	leaq	_ZSt4cout(%rip), %rdi	#,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rsi	# color.D.94849._M_impl.D.94184._M_finish, color.D.94849._M_impl.D.94184._M_finish
	subq	64(%rsp), %rsi	# color.D.94849._M_impl.D.94184._M_start, _103
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movabsq	$-6148914691236517205, %rax	#, tmp352
# /usr/include/c++/15/bits/ostream.h:179:       { return _M_insert(__n); }
	leaq	_ZSt4cout(%rip), %rdi	#,
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	sarq	$5, %rsi	#, tmp350
	imulq	%rax, %rsi	# tmp352, __dif_104
# /usr/include/c++/15/bits/ostream.h:179:       { return _M_insert(__n); }
	call	_ZNSo9_M_insertImEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$4, %edx	#,
	leaq	.LC12(%rip), %rsi	#,
	movq	%rax, %rdi	# _100,
# /usr/include/c++/15/bits/ostream.h:179:       { return _M_insert(__n); }
	movq	%rax, %rbp	#, _100
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:146:     std::cout << "Frames: " << color.size() << " at " << color[0].cols << "x" << color[0].rows
	movq	64(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_start, color.D.94849._M_impl.D.94184._M_start
	movq	%rbp, %rdi	# _100,
	movl	12(%rax), %esi	# MEM[(struct value_type &)_106].cols, MEM[(struct value_type &)_106].cols
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$1, %edx	#,
	leaq	.LC13(%rip), %rsi	#,
	movq	%rax, %rdi	# _53,
# lab5.cpp:146:     std::cout << "Frames: " << color.size() << " at " << color[0].cols << "x" << color[0].rows
	movq	%rax, %rbp	#, _53
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:147:               << "; median of " << reps << " repetitions (ms/frame)\n"
	movq	64(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_start, color.D.94849._M_impl.D.94184._M_start
	movq	%rbp, %rdi	# _53,
	movl	8(%rax), %esi	# MEM[(struct value_type &)_107].rows, MEM[(struct value_type &)_107].rows
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$12, %edx	#,
	leaq	.LC14(%rip), %rsi	#,
	movq	%rax, %rdi	# _56,
# lab5.cpp:147:               << "; median of " << reps << " repetitions (ms/frame)\n"
	movq	%rax, %rbp	#, _56
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# lab5.cpp:148:               << "Grayscale: " << grayMs << "\nSobel: " << sobelMs << "\nTotal: " << totalMs << "\n";
	movl	36(%rsp), %esi	# reps,
	movq	%rbp, %rdi	# _56,
	call	_ZNSolsEi@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$24, %edx	#,
	leaq	.LC15(%rip), %rsi	#,
	movq	%rax, %rdi	# _58,
# lab5.cpp:148:               << "Grayscale: " << grayMs << "\nSobel: " << sobelMs << "\nTotal: " << totalMs << "\n";
	movq	%rax, %rbp	#, _58
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
	movl	$11, %edx	#,
	leaq	.LC16(%rip), %rsi	#,
	movq	%rbp, %rdi	# _58,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%r13, %xmm0	# _46,
	movq	%rbp, %rdi	# _58,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$8, %edx	#,
	leaq	.LC17(%rip), %rsi	#,
	movq	%rax, %rdi	# _108,
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%rax, %rbp	#, _108
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%r14, %xmm0	# _48,
	movq	%rbp, %rdi	# _108,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$8, %edx	#,
	leaq	.LC18(%rip), %rsi	#,
	movq	%rax, %rdi	# _109,
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%rax, %rbp	#, _109
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
# /usr/include/c++/15/bits/ostream.h:232:       { return _M_insert(__f); }
	movq	%r15, %xmm0	# _50,
	movq	%rbp, %rdi	# _109,
	call	_ZNSo9_M_insertIdEERSoT_@PLT	#
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$1, %edx	#,
	leaq	.LC19(%rip), %rsi	#,
	movq	%rax, %rdi	# _110,
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
.LEHE20:
# lab5.cpp:149: }
	movq	%rbx, %rdi	# tmp386,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# lab5.cpp:149: }
	movq	%r12, %rdi	# tmp385,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# lab5.cpp:149: }
	movq	(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# /usr/include/c++/15/bits/basic_string.h:896:       { _M_dispose(); }
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT	#
# lab5.cpp:149: }
	movq	440(%rsp), %rax	# D.374312, tmp426
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp426
	jne	.L324	#,
	addq	$456, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax	#
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
.L277:
	.cfi_restore_state
# /usr/include/c++/15/bits/vector.tcc:123: 	  _M_realloc_append(std::forward<_Args>(__args)...);
	movq	(%rsp), %rdi	# %sfp,
.LEHB21:
	call	_ZNSt6vectorIN2cv3MatESaIS1_EE17_M_realloc_appendIJS1_EEEvDpOT_	#
.LEHE21:
	jmp	.L278	#
.L319:
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	72(%rsp), %rsi	# color.D.94849._M_impl.D.94184._M_finish, _156
# /usr/include/c++/15/bits/stl_vector.h:1119: 	ptrdiff_t __dif = this->_M_impl._M_finish - this->_M_impl._M_start;
	movq	64(%rsp), %rax	# color.D.94849._M_impl.D.94184._M_start, _157
	jmp	.L284	#
.L318:
# /usr/include/stdlib.h:487:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	24(%r12), %rdi	# MEM[(char * *)argv_23(D) + 24B], MEM[(char * *)argv_23(D) + 24B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# /usr/include/c++/15/bits/stl_algobase.h:263:       if (__a < __b)
	movl	$3, %edx	#, tmp423
	cmpl	%edx, %eax	# tmp423, _82
	cmovl	%edx, %eax	# _82,, tmp423, iftmp.1_14
	jmp	.L273	#
.L270:
# /usr/include/c++/15/bits/char_traits.h:423: 	if (__n == 0)
	testq	%rax, %rax	# tmp401
	je	.L271	#,
	movq	%rbx, %rdi	# _133, _133
	jmp	.L269	#
.L323:
# /usr/include/c++/15/bits/ostream.h:739: 	__ostream_insert(__out, __s,
	movl	$60, %edx	#,
	leaq	.LC6(%rip), %rsi	#,
	leaq	_ZSt4cerr(%rip), %rdi	#,
.LEHB22:
	call	_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l@PLT	#
.LEHE22:
	jmp	.L282	#
.L321:
# /usr/include/c++/15/bits/stl_iterator.h:1059:       : _M_current(__i) { }
	movq	72(%rsp), %rdx	# MEM[(const struct Mat * const &)&color + 8], _147
	movq	64(%rsp), %rcx	# MEM[(const struct Mat * const &)&color], _148
	jmp	.L280	#
.L324:
# lab5.cpp:149: }
	call	__stack_chk_fail@PLT	#
.L301:
	endbr64	
	movq	%rax, %rbx	# tmp422, tmp378
	jmp	.L297	#
.L304:
	endbr64	
# lab5.cpp:113: }
	movq	%rax, %rbx	# tmp409, tmp286
	jmp	.L297	#
.L305:
	endbr64	
# lab5.cpp:110:         }
	movq	%rax, %rbp	#, tmp408
	jmp	.L291	#
.L306:
	endbr64	
# lab5.cpp:103:     }
	movq	%rax, %rbx	# tmp407, tmp278
	jmp	.L289	#
.L302:
	endbr64	
# lab5.cpp:149: }
	movq	%rax, %rbx	# tmp421, tmp373
	jmp	.L296	#
.L303:
	endbr64	
	movq	%rax, %rbp	#, tmp420
	jmp	.L295	#
.L307:
	endbr64	
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	jmp	.L288	#
	.section	.gcc_except_table
.LLSDA10501:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE10501-.LLSDACSB10501
.LLSDACSB10501:
	.uleb128 .LEHB11-.LFB10501
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB12-.LFB10501
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L305-.LFB10501
	.uleb128 0
	.uleb128 .LEHB13-.LFB10501
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L304-.LFB10501
	.uleb128 0
	.uleb128 .LEHB14-.LFB10501
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L305-.LFB10501
	.uleb128 0
	.uleb128 .LEHB15-.LFB10501
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L304-.LFB10501
	.uleb128 0
	.uleb128 .LEHB16-.LFB10501
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L306-.LFB10501
	.uleb128 0
	.uleb128 .LEHB17-.LFB10501
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L307-.LFB10501
	.uleb128 0
	.uleb128 .LEHB18-.LFB10501
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L301-.LFB10501
	.uleb128 0
	.uleb128 .LEHB19-.LFB10501
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L302-.LFB10501
	.uleb128 0
	.uleb128 .LEHB20-.LFB10501
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L303-.LFB10501
	.uleb128 0
	.uleb128 .LEHB21-.LFB10501
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L307-.LFB10501
	.uleb128 0
	.uleb128 .LEHB22-.LFB10501
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L306-.LFB10501
	.uleb128 0
.LLSDACSE10501:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC10501
	.type	main.cold, @function
main.cold:
.LFSB10501:
.L295:
	.cfi_def_cfa_offset 512
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# lab5.cpp:149: }
	movq	%rbx, %rdi	# tmp386,
	movq	%rbp, %rbx	# tmp420, tmp373
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
.L296:
	movq	%r12, %rdi	# tmp385,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
.L297:
	movq	(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIN2cv3MatESaIS1_EED1Ev	#
# /usr/include/c++/15/bits/basic_string.h:896:       { _M_dispose(); }
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT	#
	movq	440(%rsp), %rax	# D.374312, tmp427
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp427
	jne	.L325	#,
	movq	%rbx, %rdi	# tmp292,
.LEHB23:
	call	_Unwind_Resume@PLT	#
.L291:
# lab5.cpp:110:         }
	movq	%rbx, %rdi	# tmp387,
	movq	%rbp, %rbx	# tmp408, tmp286
	call	_ZN2cv3MatD1Ev@PLT	#
	jmp	.L297	#
.L288:
# lab5.cpp:101:         while (static_cast<int>(frames.size()) < count && video.read(frame)) frames.push_back(frame.clone());
	movq	%rbx, %rdi	# tmp387,
	movq	%rax, %rbx	#, tmp278
	call	_ZN2cv3MatD1Ev@PLT	#
.L289:
# lab5.cpp:103:     }
	movq	%r12, %rdi	# tmp391,
	call	_ZN2cv3MatD1Ev@PLT	#
	movq	%rbp, %rdi	# tmp388,
	call	_ZN2cv12VideoCaptureD1Ev@PLT	#
	jmp	.L297	#
.L325:
	call	__stack_chk_fail@PLT	#
.L313:
# /usr/include/c++/15/bits/basic_string.h:711: 	  std::__throw_logic_error(__N("basic_string: "
	movq	440(%rsp), %rax	# D.374312, tmp425
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp425
	jne	.L326	#,
	leaq	.LC5(%rip), %rdi	#,
	call	_ZSt19__throw_logic_errorPKc@PLT	#
.LEHE23:
.L326:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE10501:
	.section	.gcc_except_table
.LLSDAC10501:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC10501-.LLSDACSBC10501
.LLSDACSBC10501:
	.uleb128 .LEHB23-.LCOLDB21
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSEC10501:
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
