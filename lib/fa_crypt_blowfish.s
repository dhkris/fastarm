// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
//  Blowfish block encryption implementation.
//          WORK IN PROGRESS
//         ------------------
//
.arch armv6
.fpu vfp
.data
.text

.include "fastarm.s"

.balign 4

// r0: x [uint32], r1: S
fa_blowfish_sboxexpn:
    MOV r3, r0
    LSR r3, #24
    LDR r2, [r1, r3]    // S[0][x >> 24]

    MOV r3, r0
    LSR r3, #16
    AND r3, #255
    MOV r4, #(1 << 8)   // S[1][n]
    ADD r3, r4
    LDR r4, [r1, r3]    // S[1][(x >> 16) % 256]

    ADD r2, r4          // h = S[0][x >> 24] + S[1][(x >> 16) % 256]

    MOV r3, r0
    LSR r3, #8
    AND r3, #255
    MOV r4, #(2 << 8)   // S[2][n]
    ADD r3, r4
    LDR r4, [r1, r3]    // S[2][(x >> 8) % 256]
    EOR r2, r4          // h = h ^ S[2][(x >> 8) % 256]

    MOV r3, r0
    AND r3, #255
    MOV r4, #(3 << 8)   // S[3][n]
    ADD r3, r4
    LDR r4, [r1, r3]
    ADD r2, r4          // h + S[3][x % 256]

    MOV r0, r2          // return h



.global fa_blowfish_init
.func fa_blowfish_init
fa_blowfish_init:
    BX      LR

.endfunc



