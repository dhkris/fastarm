// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized vector fused multiply-[add|subtract] operations.
//
//
.arch armv6
.fpu vfp

.include "fastarm.s"

.balign 4
.text

// The fastest possible FMA implementation. Requires that input data
// be stored in a packed format:
//
// | Position  | 3n | 3n+1 | 3n+2 |
// |   Datum   | an |  bn  |  cn  |
//
// The function implements the general calculation:
// out[i] = in[3i] + (in[3i+1] * in[3i+2])
//
// In other words,
// out[0] = in[0] + (in[1] * in[2])
// out[1] = in[3] + (in[4] * in[5])
// and so on...
//
// Use the utility function, float* fa_vecpack3(float* a, float* b, float* c, unsigned count)
// to generate a packed pointer suitable for this
.global fa_vecpacked_fmaf
.balign 4
.func fa_vecpacked_fmaf

.endfunc

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
	save_registers
	MOV			r5,     #0
	LSL			r3,     #2
	BL			.fa_vecfmaf_loop
	SUB			r0,     r5
	load_registers
	BX			lr

.fa_vecfmaf_loop:
	VLDR.F32	s0,		[r0]            // a_i
	VLDR.F32	s1,		[r1]            // b_i
	VLDR.f32	s2,		[r2]            // c_i
	VMLA.F32	s0,		s1,         s2	// buf = a_i + (b_i * c_i)
	VSTR		s0,		[r0]            // a_i = buf
	ADD			r5,     #4				// increment addresses...
	ADD			r0,     #4				// ...
	ADD			r1,     #4				// ...
	ADD			r2,     #4				// ...
	CMP			r5,     r3
	BXEQ		lr
	B			.fa_vecfmaf_loop

.endfunc

// For I in [0; length[:
//		a[i] = a[I] - (b[I] + c[I])
//
//	All pointers must be preallocated
// float* fa_vecfmsf(float* a, float* b, float* c, unsigned length)
//	returns a
.balign 4
.global fa_vecfmsf
.func fa_vecfmsf

fa_vecfmsf:
	save_registers
	MOV			r5, #0
	LSL			r3, #2
	BL			.fa_vecfmsf_loop
	SUB			r0, r5
	load_registers
	BX			lr

.fa_vecfmsf_loop:
	VLDR.F32	s0,		[r0]		// a_i
	VLDR.F32	s1,		[r1]		// b_i
	VLDR.f32	s2,		[r2]		// c_i
	VMLS.F32	s0,		s1,		s2	// buf = a_i + (b_i * c_i)
	VSTR		s0,		[r0]		// a_i = buf
	ADD			r5, #4				// increment addresses...
	ADD			r0, #4				// ...
	ADD			r1, #4				// ...
	ADD			r2, #4				// ...
	CMP			r5, r3				
	BXEQ		lr
	B			.fa_vecfmsf_loop

.endfunc

