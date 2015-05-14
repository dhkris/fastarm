// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
.arch armv6
.fpu vfp

.include "fastarm.s"

.text
.balign 4

//Fast inverse floating-point
//
//float fa_isqrtf(float a)
//  s0				s0
//
.global fa_isqrtf_fast
.func fa_isqrtf_fast
fa_isqrtf_fast:
	save_registers
	
	// Synthesize 1.5
	MOV			r6, #(0xC0 << 16)
	ORR			r6, #(0x3F << 24)
	VMOV.F32	s8, r6					// 1.5
	
	// Synthesize 0.5
	MOV			r6, #(0x3F << 24)
	VMOV.F32	s9, r6					// 0.5
	
	// Generate constants
	VMOV.F32	s10, s0					// y
	VMUL.F32	s11, s9, s10			// x2
	VMOV.F32	r7, 	s10			// i
	
	// Synthesize magic number
	MOV			r5, #0xDF
	ORR			r5, #(0x59 << 8)
	ORR			r5, #(0x37 << 16)
	ORR			r5, #(0x5F << 24)
	
	// Perform trickery
	LSR			r7, #1
	SUB			r5, r7	
	VMOV.F32	s10, r5
	
	// Newton
	VMUL.F32	s5, s10, s10	// bufa = y * y
	VMUL.F32	s6, s5, s11		// bufb = bufa * x2
	VSUB.F32	s2, s8, s6		// bufc = 1.5 - bufb
	VMUL.F32	s10, s2, s10 	// retval = y * bufc
	
	// Prepare for return
	VMOV.F32	s0, s10
	
	load_registers
	BX 			lr

.endfunc

.balign 4
.global fa_isqrtf
.func fa_isqrtf
fa_isqrtf:
	save_registers
	
	// Synthesize 1.5
	MOV			r6, #(0xC0 << 16)
	ORR			r6, #(0x3F << 24)
	VMOV.F32	s8, r6					// 1.5
	
	// Synthesize 0.5
	MOV			r6, #(0x3F << 24)
	VMOV.F32	s9, r6					// 0.5
	
	// Generate constants
	VMOV.F32	s10, s0					// y
	VMUL.F32	s11, s9, s10			// x2
	VMOV.F32	r7, 	s10			// i
	
	// Synthesize magic number
	MOV			r5, #0xDF
	ORR			r5, #(0x59 << 8)
	ORR			r5, #(0x37 << 16)
	ORR			r5, #(0x5F << 24)
	
	// Perform trickery
	LSR			r7, #1
	SUB			r5, r7	
	VMOV.F32	s10, r5
	
	// Newton * 2
	VMUL.F32	s5, s10, s10	// bufa = y * y
	VMUL.F32	s6, s5, s11		// bufb = bufa * x2
	VSUB.F32	s2, s8, s6		// bufc = 1.5 - bufb
	VMUL.F32	s10, s2, s10 	// retval = y * bufc
	VMUL.F32	s5, s10, s10	// bufa = y * y
	VMUL.F32	s6, s5, s11		// bufb = bufa * x2
	VSUB.F32	s2, s8, s6		// bufc = 1.5 - bufb
	VMUL.F32	s10, s2, s10 	// retval = y * bufc	
		
	// Prepare for return
	VMOV.F32	s0, s10
	
	load_registers
	BX 			lr

