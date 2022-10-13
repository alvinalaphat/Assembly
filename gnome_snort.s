			;##########################################
			;		Lab 01 Gnome Sort Skeleton
			;##########################################
			
data_to_sort	dcd		17, 80, 2, 3, 18, 54, 29, 11, 15, 40
list_elements	dcd		10
			
main			ldr		r3, =data_to_sort   ; Load the starting address of the first
			;		of element of the array of numbers into r3
			ldr		r4, =list_elements  ; address of number of elements in the list
			ldr		r4, [r4]            ; number of elements in the list
			
			add		r5, r3, #400	 ; location of first element of linked list - "head pointer"
			mov		r13, r5		; dont touch r13
			;		(note that I assume it is at a "random" location
			;		beyond the end of the array.)
			
			
			;#################################################################################
			;		Include any setup code here prior to the loop that will create the linked list
			;#################################################################################
			;		r0: NULL
			;		r1: current pointer
			;		r2: previous pointer
			;		r3: data_to_sort array pointer
			;		r4: number of list elements
			;		r5: head pointer
			;		r6: address of addr of next struct
			;		r7: offset
			;		r8: insert_loop counter
			;		r9: sorting position
			;		r10: flag for if statement
			;		r14: link register
			;		r15: program counter
			
			
			mov		r7, #0  ; offset from data_to_sort array
			mov		r1, r5      ; Move head addr to r1
			mov		r2, #0  ; previous pointer
			
			
			;#################################################################################
			;		Start a loop here to load elements in the array and add them to a linked list
			;#################################################################################
			
			mov		r8, #0      ; loop counter
insert_loop
			cmp		r8, r4		; r4 is number of elements to load/insert
			bge		done_insert
			ldr		r0, [r3, r7]    ; Load the data from array
			add		r6, r1, #32		; Get addr for next struct
			
			bl		insert        ; FIGURE OUT WHAT TO DO HERE
			
			mov		r2, r1          ; r2 gets first addr of previous struct
			mov		r1, r6		    ; move addr for next struct to r1
			add		r7, r7, #4      ; increment offset for accessing data_to_sort array
			
			add		r8, r8, #1       ; increment loop counter
			
			b		insert_loop
			
			
done_insert
			mov		r0, #0
			sub		r1, r1, #32	; get back to last element
			str		r0, [r1, #8]	; give last value's next NULL
			mov		r0, r5				; put the head pointer back into r0
			mov		r8, #0			; initialize offset for swaps
			;mov		r11, #8
			b		sort
			
			
			
			;#################################################################################
			;		Add insert, swap, delete functions here
			;#################################################################################
			
insert
			str		r0, [r1]        ; store data
			str		r2, [r1, #4]     ; store prev		switch r2 and r0
			str		r6, [r1, #8]    ; store next
			mov		r15, r14
			
			
			mov		r9, #0		; initialize gnomesort position counter
			;mov		r8, #0		; initialize offset for swaps
			;mov		r11, #8
sort
			cmp		r9, r4		; while position < number of list_elements
			bge		done
			;mov		r10, #0		; initialize flag
			cmp		r9, #0		; compare position to 0
			beq		pos_inc
			
resume
			
			ldr		r3, [r5, #0]	; this is a[pos-1]; R3 IS NOT GETTING UPDATED AT EACH ITERATION THIS IS VERY IMPORTANT MAN iT STAYS AT 17 BRUH
			ldr		r7, [r5, #8]
			ldr		r6, [r7, #0]	; a[pos]
			;mov		r5, r7
			;add		r8, r8, #32
			;add		r11, r11, #32
			cmp		r6, r3				; if a[pos] >= a[pos-1]
			blt		swap
			
			;b		swap
			;sub		r9, r9, #1
			
			
pos_inc
			;cmp		r10, #1
			;beq		sort
			cmp		r9, #0
			beq		dont_mv_r7_r5
			
			;b		sort
			ldr		r7, [r5, #8]
			add		r9, r9, #1
			mov		r5, r7
			;ldr		r5, [r7, #0]
			;mov		r10, #1
			b		sort
dont_mv_r7_r5
			ldr		r7, [r5, #8]
			add		r9, r9, #1
			;mov		r5, r7
			;ldr		r5, [r7, #0]
			;mov		r10, #1
			b		sort
			
			
swap
			;		6 loads and then 6 stores
			ldr		r10, [r7, #0]
			ldr		r11, [r0, #0]
			ldr		r12, [r5, #0]
			ldr		r8, [r7, #32]

			str		r10, [r1]
			str		r10, [r2]
			str		r8, [r4]
			str		r11, [r10]
			str		r12, [r8]
			str		r12, [r11]
			
			sub		r9, r9, #1
			mov 	r7, r0
			b		sort
			
			
			
			;#################################################################################
			;		This ends the program. You can branch to `done` or move this code as you'd like,
			;		BUT it is important this is executed (last) to end execution cleanly.
			;#################################################################################
done
			end