// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
.arch armv6
.fpu vfp
.data
.text

.global fa_rc4_prepare
.func fa_rc4_prepare

.balign 4

// r0: Output pointer, preallocated
fa_rc4_prepare:
	MOV 	r4,		#(1 << 8) // base value
	ORR		r4,		#(2 << 16)
	ORR		r4,		#(4 << 24)
	MOV 	r5,		#1 // parallel address addition
	ORR		r5,		#(2 << 8)
	ORR		r5,		#(3 << 16)
	ORR		r5,		#(4 << 24)
	MOV 	r2,		r0
	MOV 	r3,		r0
	ADD 	r3,		#256
	MOV		r8, 	lr					// We don't need no stackification'
	BL		.fa_rc4_prepare_loop1
	BX		r8

.balign 4
.fa_rc4_prepare_loop1:
	STR 	r4,		[r2]
	UADD8 	r4, 	r4, 	r5	// 4x byte parallel additions
	ADD 	r2, 	#4
	CMP 	r2, 	r3
	BXEQ 	lr
	BNE 	.fa_rc4_prepare_loop1
	
.endfunc	
	

.global fa_rc4_init
.func fa_rc4_init

.balign 4
// unsigned char* fa_rc4_init(unsigned char* key, unsigned keylen, unsigned char* prepared)
fa_rc4_init:
	MOV		r5,		#0							//i
	MOV 	r6, 	#0
	MOV		r10,	r0
	SUB		r10,	#1									//j
	PUSH	{lr}
	BL		.fa_rc4_init_loop1
	MOV		r0,		r2							// return schedule
	POP		{lr}
	BX		lr

.balign 4
.fa_rc4_init_loop1:
	MOV		r7, 	r5				//il = i
	AND		r7,		r10					//			% keylen
	LDRB	r3,		[r2, r5]			//S[i]
	LDRB	r4,		[r0, r7]			//key[i % keylen]
	ADD		r6,		r3
	ADD		r6,		r4
	AND		r6,		#255
		
	LDRB	r3,		[r2, r6]			
	LDRB	r4,		[r2, r5]
	STRB	r3,		[r2, r5]
	STRB	r4,		[r2, r6]
	
	ADD		r5,		#1
	CMP		r5,		#256
	BNE		.fa_rc4_init_loop1
	BXEQ	LR

.endfunc	
	
// char* fa_rc4_encrypt(uint8_t* bytes, uint32_t length, uint8_t* schedule, uint8_t* output)
//
// INPUT ARGUMENTS:
// 	bytes: Input bytes
//  length: Number of input bytes
//  schedule: Key schedule. If at start of stream, from fa_rc4_init, otherwise
//			  the return value of the previous call to fa_rc4_encrypt.
//	output: Preallocated pointer of (length) bytes.
//
//	RETURNS:
//	Pointer to reshuffled key schedule for subsequent calls.
//

.global fa_rc4_encrypt
.func fa_rc4_encrypt

fa_rc4_encrypt:
	MOV		r5,		#0			// i
	MOV		r6,		#0			// j
	MOV		r7,		#0			// n in 0...length
	MOV		r12,	lr
	BL		.fa_rc4_encrypt_pass
	MOV		r2,		r0
	BX		r12
	
.fa_rc4_encrypt_pass:
	ADD		r5,		#1
	AND		r5,		#255
	LDRB	r8,		[r2, r5]	// S[i]
	ADD		r6,		r8
	AND		r6,		#255
	LDRB	r9,		[r2, r6]	// S[j]
	
	STRB	r9,		[r2, r5]
	STRB	r8,		[r2, r6]
	ADD		r8,		r9
	AND		r8,		#255
	LDRB	r9,		[r2, r8]	// S[S[i] + S[j] % 256]
	LDRB	r8,		[r0, r7]	// current byte
	EOR		r8,		r9
	STRB	r8,		[r3, r7]
	ADD		r7,		#1
	CMP		r7,		r1
	BNE		.fa_rc4_encrypt_pass
	BXEQ	lr
	
	ADD		r7,		#1
	

.endfunc

