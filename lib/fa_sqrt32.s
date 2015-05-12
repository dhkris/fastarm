// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// Optimized integer square root
//
// Call:
//		float fa_sqrt32(unsigned number)
//
	
.arch armv6
.fpu vfp
.balign 4
.text

.balign 4
.global fa_sqrt32
.func fa_sqrt32
	
//-------------------------------------------------------
//		R0: number, R1: bit, R2: result, R3: bit + number
//
//		Linking registers:
//			R7:	fa_sqrt32 --> caller
fa_sqrt32:			
	MOV			r1, #1					// bit = 1
	LSL			r1, #30					// bit <<= 30
	MOV			r2, #0					// res = 0	
	MOV			r7, lr
    BL 			.__lib_fa_sqrt32_loop1
    BL			.__lib_fa_sqrt32_loop2
    MOV			r0, r2					// return res
    BX 			r7
//-------------------------------------------------------

.__lib_fa_sqrt32_loop1:			
	CMP			r1,		r0
	LSRGT		r1,		#2
	BGT			.__lib_fa_sqrt32_loop1
	BX			LR			
	
.__lib_fa_sqrt32_loop2:					
	CMP			r1,		#0
	BXEQ		lr			
	MOV			r3,		r2		
	ADD			r3,		r1	

	CMP			r0,		r3	
	
	SUBHS		r0,		r3
	LSRHS		r2,		#1
	ADDHS		r2,		R1
	
	LSRLO		r2, 	#1
	
	LSR			r1,		#2
	B			.__lib_fa_sqrt32_loop2
	
.endfunc