.arch armv6
.fpu vfp


.data

.balign 4

.text
TestString : .asciz "FSiz: %d, FCount: %d, FAddr: %d, FSwapd: %d\n"
Swapper : .asciz "Swapped\n"

.balign 4
.global fbubblesort
.func fbubblesort

// Register plan
// CALL:
//	void* faqsort(void* data, unsigned size, unsigned count)
//	                 R0            R1              R2
//
//	Current index: R3
//	Buffers: R5, R6
fbubblesort:
	push {lr}			// stack += return address
	bl fbubblesort_outer		// fbubblesort_outer()
	pop {lr}			// return address = pop stack
	bx lr				// return to caller

// Outer loop
// R4: Swapped (=0) or not (!=0)
fbubblesort_outer:
	mov r4, #0			// swapped = false
	// Compute end address
	mov r11, r1			// int end = size
	mul r11, r2			//		  * count  
	add r11, r0			//			  + start;
	

	// Copy starting address
	mov r3, r0			// int start = data
	add r3, #4			//			+ size

	push {lr}
	bl fbubblesort_inner		// fbubblesort_inner()
//	sub r11, r1			// end -= size
	pop {lr}

	mov r10, #0			
	cmp r4, r10			// swapped == false
	bxeq lr				//   true: return to caller
	bne fbubblesort_outer		//   false: goto top ^^

// Loop pos: R3
fbubblesort_inner:
	mov r6, r0
	push {r1,r2,r3}
	push {r0}
	adr r0, TestString
	push {lr}
	push {r11}
	bl printf
	pop {r11}
	pop {lr}
	push {r0}
	pop {r3, r2, r1}
	mov r0, r6
	mov r8, r3			// int previous_addr = R3
	sub r8, #4			//			  - sizeof(*data)

	push {lr}
	push {r1, r2, r3}
	push {r0}
	adr r0, TestString
	mov r2, r8
	bl printf
	pop {r0}
	pop {r3, r2, r1}

	ldr r9, [r8]			// int a = data[i - 1];
	ldr r10, [r3]			// int b = data[i];
	cmp r9, r10			// a > b
	push {r0, r1, r2, r3}
	bllo fbubble_swap		// true:	fbubble_swap();
	pop {r3, r2, r1, r0}
	pop {lr}
	add r3, #4
	cmp r3, r11			// current_address == end of data?
	bxeq lr				// true:  goto *return_addr
	bne fbubblesort_inner		// false: loop to top ^^

fbubble_swap:
	push {r0, r1, r2, r3}
	adr r0, Swapper
	push {lr}
	bl puts
	pop {lr}
	pop {r3, r2, r1, r0}
	str r10, [r8]
	str r9, [r3] 
	ldr r9, [r8]
	ldr r10, [r3]
	bx lr				// return to caller ^^

.endfunc
