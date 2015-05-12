// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license
//
// 64-bit arithmetic macros
//

.arch armv6
.fpu vfp

// [r4,r5] = [r0,r1] + [r2, r3]
.macro add64  onelo=r0, onehi=r1, twolo=r2, twohi=r3, destlo=r4, desthi=r5
	ADDS 	\destlo, 	\onelo, 	\twolo
	ADC 	\desthi, 	\onehi, 	\twohi
.endm

// [r4,r5] = [r0,r1] - [r2, r3]
.macro sub64, fromlo=r0, fromhi=r1, twolo=r2, twohi=r3, destlo=r4, desthi=r5
	SUBS 	\destlo, 	\onelo, 	\twolo
	SBC 	\desthim	\onehi,		\twohi
.endm