;; SLAE Assignment #6: Orignal Shellcode ping localhost
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Original ShellCode:  http://shell-storm.org/shellcode/files/shellcode-632.php

global _start			

section .text
_start:
	push byte +0xb
	pop eax
	cdq
	push edx
	push dword 0x20207473
	push dword 0x6f686c61
	push dword 0x636f6c20
	push dword 0x676e6970
	mov esi,esp
	push edx
	push word 0x632d
	mov ecx,esp
	push edx
	push dword 0x68732f2f
	push dword 0x6e69622f
	mov ebx,esp
	push edx
	push esi
	push ecx
	push ebx
	mov ecx,esp
	int 0x80
