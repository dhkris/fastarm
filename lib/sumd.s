//
// fastarm
// Fast ARM math building blocks
//
// Copyright (c) David H. Christensen
// Licensed under the MIT license
//
.arch armv6
.fpu vfp


.data
.balign 4

.text

.balign 4

// SUMD
// Double summation using VFP instructions
// Input chart:
// r0: Pointer to start of data (double* data)
// r1: Number of items (uint32_t length)
.global sumh
.func sumh
sumh:
	// Initialize FP register
	mov r5, #0
	vmov d0, r5

	// Compute maximum address
	lsl r1, #2
	add r1, r0

	// Preserve link register, call and return
	mov r10, lr
	bl sumf_inner
	mov lr, r10
	vmov r0, d0
	bx lr

// R0: Current
// R1: Max
// S0: Acc
sumh_inner:
	vldr.F64 d1, [r0]
	vadd.F64 d0, d1
	add r0, #8
	cmp r0, r1
	bne sumf_inner
	bxeq lr	

.endfunc
