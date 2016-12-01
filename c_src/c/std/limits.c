//
// Created by yj on 16-11-30.
//

#include <stdio.h>
#include <limits.h>

int main() {
    printf("the number of bits in a byte %d\n", CHAR_BIT);

    printf("the minimum value of SIGNED CHAR = %d\n", CHAR_MIN);
    printf("the maximum value of SIGNED CHAR = %d\n", CHAR_MAX);
    printf("the maximum value of UNSIGNED CHAR = %d\n", UCHAR_MAX);

    printf("the minimum value of SHORT INT = %d\n", SHRT_MIN);
    printf("the maximum value of SHORT INT = %d\n", SHRT_MAX);

    printf("min of INT = %d\n", INT_MIN);
    printf("max of INT = %d\n", INT_MAX);

    printf("min of CHAR = %d\n", CHAR_MIN);
    printf("max of CHAR = %d\n", CHAR_MAX);

    printf("min of LONG = %ld\n", LONG_MIN);
    printf("max of LONG = %ld\n", LONG_MAX);

    return 0;
}