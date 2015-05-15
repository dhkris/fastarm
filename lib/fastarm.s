// Fastarm 1.0
// Copyright (c) David H. Christensen, 2015.
// Licensed under the MIT license

// Preserve callee-saved integer registers
.macro save_registers
	PUSH {r4-r9, sl, fp, lr}
.endm

// Reload callee-saved integer registers
.macro load_registers
	POP	{r4-r9, sl, fp, lr}
.endm

// Preserve callee-saved floating point registers
// Saved as doubles for slightly faster performance
.macro save_fp_registers
	VPUSH.F64 {d8-d15}
.endm

// Reload callee-saved floating point registers
.macro load_fp_registers
	VPOP.F64 {d8-d15}
.endm
