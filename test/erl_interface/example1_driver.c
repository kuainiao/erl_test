
#include <stdio.h>
#include <stdlib.h>

typedef unsigned char byte;

int read_cmd(byte *buff);
int write_cmd(byte *buff, int len);
int foo(int x);
int bar(int y);

int main(){
    int fn, arg, res;
    byte buff[100];

    while (read_cmd(buff) > 0) {
        fn = buff[0];
        arg = buff[1];

    if (fn == 1) {
        res = foo(arg);
    } else if (fn == 2) {
        res = bar(arg);
    }

    buff[0] = res;
    write_cmd(buff, 1);
    }
}