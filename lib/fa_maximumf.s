// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized global maximum finder
//
// C header: famaximum.h
// Call:
//		float fa_maximumf(float* data, unsigned count)
//
	
.arch armv6
.fpu vfp
.balign 4
.text

.balign 4
.global fa_maximumf
.func fa_maximumf

//-------------------------------------------------------
// R0: Pointer to data
// R1: Count
fa_maximumf:
    MOV 		r5, 	r1			// Count
    MOV 		r6, 	r0			// Base offset
    
    MOV 		r7, 	#0		
    VMOV.F32 	s0, 	r7	
    
    LSL 		r5, 	#2
    
    ADD 		r5, 	r6
    MOV 		r8, 	lr
    BL 			.fa_maximumf_inner
    VMOV 		r0, 	s0
    BX 			r8 
//-------------------------------------------------------

.fa_maximumf_inner:
    CMP 		r5, 	r6
    BXEQ 		lr
    VLDR.F32 	s1, 	[r6]
	VCMP.F32 	s1, 	s0
	VMOVGT.F32 	s0, 	s1
    ADD 		r6, 	#4
    B 			.fa_maximumf_inner

.endfunc
