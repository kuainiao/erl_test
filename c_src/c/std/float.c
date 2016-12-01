//
// Created by yj on 16-11-30.
//

#include <float.h>
#include <stdio.h>

int main() {
    printf("the maximun value of float = %.10e\n", FLT_MAX);
    printf("the minimun value of float = %.10e\n", FLT_MIN);

    printf("the number of digits in the number = %.10e\n", FLT_MANT_DIG);

    return 0;
}