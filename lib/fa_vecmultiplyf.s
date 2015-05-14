// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized vector multiplication without any memory accesses except
// the loading and storing of input and output data.
// All other operations are kept to registers.
// Also, as few branches as possible are taken, and when possible,
// without any linking.
//
// Call:
//		float fa_sqrt32(unsigned number)
//
.arch armv6
.fpu vfp

.include "fastarm.s"

.balign 4
.text

// For I in [0; length[:
//		destination[I] = a[I] * b[I]
//
//	All pointers must be preallocated
// void fa_vecmultiplyf(float* a, float* b, float* destination, unsigned length)
.balign 4
.global fa_vecmultiplyf
.func va_vecmultiplyf

fa_vecmultiplyf:
	save_registers
	MOV			r5,     #0
	LSL			r3,     #2
	BL			.fa_vecmultiplyf_loop
	load_registers
	BX			lr

.fa_vecmultiplyf_loop:
	VLDR.F32	s0,		[r0]
	VLDR.F32	s1,		[r1]
	VMUL.F32	s2,		s1,		s0
	VSTR		s2,		[r2]
	ADD			r5,     #4
	ADD			r0,     #4
	ADD			r1,     #4
	ADD			r2,     #4
	CMP			r5,     r3
	BXEQ		lr
	B			.fa_vecmultiplyf_loop

.endfunc

