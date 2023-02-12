# SLAE32 Preparation

This Repository has been created for completing the requirements of the SecurityTube Linux Assembly Expert certification: http://securitytube-training.com/online-courses/securitytube-linux-assembly-expert/

## Student ID: SLAE-1208


# Securitytube Linux Assembly Expert 32-bits

This course focuses on teaching the basics of 32-bit assembly language for the Intel Architecture (IA-32) family of processors on the Linux platform and applying it to Infosec. Once we are through with the basics, we will look at writing shellcode, encoders, decoders, crypters and other advanced low level applications.

<img src="logo.png" alt="Logo" width="800"/>


---------------------------------------------------

## [Assignment #1](https://github.com/sandh0t/SLAE32/tree/master/Assignment_1)

- Create a Shell_Bind_TCP shellcode

	- Binds to a port

	- Execs Shell on incoming connection

- Port number should be easily configurable


---------------------------------------------------


## [Assignment #2](https://github.com/sandh0t/SLAE32/tree/master/Assignment_2)

- Create a Shell_Reverse_TCP shellcode

	- Reverse connects to configured IP and Port

	- Execs Shell on successful connection

- IP and Port number should be easily configurable


---------------------------------------------------


## [Assignment #3](https://github.com/sandh0t/SLAE32/tree/master/Assignment_3)

- Study about the Egg Hunter shellcode

- Create a working demo of the Egghunter

- Should be configurable for different payloads


---------------------------------------------------


## [Assignment #4](https://github.com/sandh0t/SLAE32/tree/master/Assignment_4)

- Create a custom encoding scheme like the "Insertion Encoder" we showed you

- PoC with using execve-stack as the shellcode to encode with your schema and execute


---------------------------------------------------

## [Assignment #5](https://github.com/sandh0t/SLAE32/tree/master/Assignment_5)

- Take up at leat 3 shellcode samples created using Msfvenom for linux/x86

- Use GDB/Ndisasm/Libemu to dissect the functionality of the shellcode

- Present your analysis

---------------------------------------------------


## [Assignment #6](https://github.com/sandh0t/SLAE32/tree/master/Assignment_6)

- Take up 3 shellcodes from Shell-Storm and create polymorphic versions of them to beat pattern matching

- The polymorphic versions cannot be larger 150% of the existing shellcode

- Bonus points for making it shorter in length than original


---------------------------------------------------


## [Assignment #7](https://github.com/sandh0t/SLAE32/tree/master/Assignment_7)

- Create a custom crypter like the one shown in the "crypters" video

- Free to use any existing encryption schema

- Can use any programming language


