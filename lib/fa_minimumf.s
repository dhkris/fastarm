// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized global minimum finder
//
// Call:
//		float fa_minimumf(float* data, unsigned count)
//
	
.arch armv6
.fpu vfp
.balign 4
.text

.balign 4
.global fa_minimumf
.func fa_minimumf

//-------------------------------------------------------
// R0: Pointer to data
// R1: Count
fa_minimumf:
    MOV 		r5, 	r1
    MOV 		r6, 	r0	
    LSL 		r5, 	#2
    ADD 		r5, 	r6

    MOV 		r7, 	#0		
    VMOV.F32 	s0, 	r7	
    
    MOV 		r8, 	lr
    BL 			.__lib_fa_minimumf_inner
    VMOV 		r0, 	s0
    BX 			r8 
//-------------------------------------------------------

.__lib_fa_minimumf_inner:
    CMP 		r5, 	r6
    BXEQ 		lr
    VLDR.F32 	s1, 	[r6]
	VCMP.F32 	s1, 	s0
	VMOVLT.F32 	s0, 	s1
    ADD 		r6, 	#4
    B 			.__lib_fa_minimumf_inner

.endfunc
