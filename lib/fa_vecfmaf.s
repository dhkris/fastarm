// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized vector fused multiply-[add|subtract] operations.
//
//
.arch armv6
.fpu vfp
.balign 4
.text

// For I in [0; length[:
//		a[i] = a[I] + (b[I] + c[I])
//
//	All pointers must be preallocated
// float* fa_vecfmaf(float* a, float* b, float* c, unsigned length)
//	returns a
.balign 4
.global fa_vecfmaf
.func fa_vecfmaf

fa_vecfmaf:
	MOV			r5, #0
	LSL			r3, #2
	MOV			r8, lr
	BL			.fa_vecfmaf_loop
	SUB			r0, r5
	BX			r8

.fa_vecfmaf_loop:
	VLDR.F32	s0,		[r0]		// a_i
	VLDR.F32	s1,		[r1]		// b_i
	VLDR.f32	s2,		[r2]		// c_i
	VMLA.F32	s0,		s1,		s2	// buf = a_i + (b_i * c_i)
	VSTR		s2,		[r0]		// a_i = buf
	ADD			r5, #4				// increment addresses...
	ADD			r0, #4				// ...
	ADD			r1, #4				// ...
	ADD			r2, #4				// ...
	CMP			r5, r3				
	BXEQ		lr
	B			.fa_vecfmaf_loop

.endfunc

// For I in [0; length[:
//		a[i] = a[I] - (b[I] + c[I])
//
//	All pointers must be preallocated
// float* fa_vecfmaf(float* a, float* b, float* c, unsigned length)
//	returns a
.balign 4
.global fa_vecfmsf
.func fa_vecfmsf

fa_vecfmsf:
	MOV			r5, #0
	LSL			r3, #2
	MOV			r8, lr
	BL			.fa_vecfmsf_loop
	SUB			r0, r5
	BX			r8

.fa_vecfmsf_loop:
	VLDR.F32	s0,		[r0]		// a_i
	VLDR.F32	s1,		[r1]		// b_i
	VLDR.f32	s2,		[r2]		// c_i
	VMLS.F32	s0,		s1,		s2	// buf = a_i + (b_i * c_i)
	VSTR		s2,		[r0]		// a_i = buf
	ADD			r5, #4				// increment addresses...
	ADD			r0, #4				// ...
	ADD			r1, #4				// ...
	ADD			r2, #4				// ...
	CMP			r5, r3				
	BXEQ		lr
	B			.fa_vecfmsf_loop

.endfunc

