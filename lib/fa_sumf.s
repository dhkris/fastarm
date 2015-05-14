// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
.arch armv6
.fpu vfp

.include "fastarm.s"

.data
.balign 4

.text

.balign 4

// SUMF
// Single-point summation using VFP instructions
// Input chart:
// r0: Pointer to start of data (float* data)
// r1: Number of items (uint32_t length)
// 
// Working store:
//   R5: Index (int i)
//   F6: Accumulator (float acc)
//   R10: Return address
//
// Returns:
// f0: FP32 sum
.global fa_sumf
.func fa_sumf
fa_sumf:
	save_registers
	// Initialize FP register
	mov r5, #0
	vmov s0, r5

	// Compute maximum address
	lsl r1, #2
	add r1, r0

	// Preserve link register, call and return
	bl sumf_inner
	load_registers
	bx lr

// R0: Current
// R1: Max
// S0: Acc
sumf_inner:
	vldr.F32 s1, [r0]
	vadd.F32 s0, s1
	add r0, #4
	cmp r0, r1
	bne sumf_inner
	bxeq lr	

.endfunc
