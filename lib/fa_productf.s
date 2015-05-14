// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized floating-point (single precision) vector product
// subroutine.
//
// C header: faproduct.h
// Call:
//		float productf(float* data, unsigned count)
//
	
.arch armv6
.fpu vfp

.include "fastarm.s"

.balign 4
.text

.balign 4
.global fa_productf
.func fa_productf

//-------------------------------------------------------
// R0: Pointer to data
// R1: Count
fa_productf:
	save_registers
    MOV r5, r1			// Count
    MOV r6, r0			// Base offset
    
    // Initialize FP register to 1.0000
    MOV r7, #1		
    VMOV.F32 s2, r7	
    VCVT.F32.U32 s0, s2
    
    // Count *= 4 (bytes)
    LSL 	r5, #2
    
    ADD 	r5, r6 // End = size + start
    BL 		.productf_inner	// Calculate
    load_registers
    BX 		lr 			// Return to caller
//-------------------------------------------------------

.productf_inner:
    CMP r5, r6
    BXEQ lr
    VLDR.F32 s1, [r6]
    VMUL.F32 s0, s1, s0
    ADD r6, #4
    B .productf_inner

.endfunc
