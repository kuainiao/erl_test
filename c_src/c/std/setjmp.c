//
// Created by yj on 16-11-30.
//

#include <stdio.h>
#include <stdlib.h>
#include <setjmp.h>

int main() {
    int val;
    jmp_buf env_buffer;

    val = setjmp(env_buffer);
    if (val != 0) {
        printf("从 longjmp() 返回值 = %s\n", val);
        exit(0);
    }
    printf("调转函数\n");
    jmpfunction(env_buffer);
    return 0;
}

void jmpfunction(jmp_buf env_buf) {
    longjmp(env_buf, "w3cschool.cc");
}