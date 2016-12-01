//
// Created by yj on 16-11-30.
//

#include <ctype.h>
#include <stdio.h>

int main() {
    int a1 = 'A';
    int a2 = '12';
    int a3 = '\n';

    printf("111 1:%d\n", isalnum(a1));
    printf("111 2:%d\n", isalnum(a2));
    printf("111 3:%d\n", isalnum(a3));

    printf("222 1:%d\n", isalpha(a1));
    printf("222 2:%d\n", isalpha(a2));
    printf("222 3:%d\n", isalpha(a3));

    printf("333 1:%d\n", iscntrl(a1));
    printf("333 2:%d\n", iscntrl(a2));
    printf("333 3:%d\n", iscntrl(a3));

    printf("444 1:%d\n", isdigit(a1));
    printf("444 2:%d\n", isdigit(a2));
    printf("444 3:%d\n", isdigit(a3));

    printf("555 1:%d\n", isgraph(a1));
    printf("555 2:%d\n", isgraph(a2));
    printf("555 3:%d\n", isgraph(a3));


    printf("666 1:%d\n", tolower(a1));
    printf("777 1:%d\n", toupper('b'));


    return 0;
}