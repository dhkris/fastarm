// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
.arch armv6
.fpu vfp

.include "fastarm.s"

.balign 4
.text

.balign 4
.data

.global fa_avgf
.func fa_avgf

// FP32 averaging function
fa_avgf:
	save_registers
	mov r8, #0				// Set register to zero
	vmov s0, r8				// Transfer to FP register
	mov r7, lr				// Save link register
	mov r3, r1				// Copy the item count
	lsl r1, #2				// One float takes 4 bytes
	add r1, r0				// And we compute the end address...
	bl avgf_inner				// Branch to avgf_inner
	vmov r0, s0				// Copy return value into register
	load_registers
	bx lr					// Return from this function

avgf_inner:
	vldr.F32 s1, [r0]			// Load 4 bytes into mem
	vadd.F32 s0, s1				// Add to accumulator
	add r0, #4				// Increment
	cmp r0, r1				// Compare current addr to max addr
    bne avgf_inner				// Loop
    vmov s9, r3				// Move item count bits into FP register
    vcvt.F32.U32 s8, s9			// Convert item count to FP32
    vdiv.F32 s0, s0, s8				// Divide sum by count
    bxeq lr					// Branch back

.endfunc
