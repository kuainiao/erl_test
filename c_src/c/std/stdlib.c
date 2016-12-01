//
// Created by yj on 16-11-30.
//

#include <stdlib.h>
#include <stdio.h>

int main() {
    double d;
    char str[20] = "3.1415926";


    d = atof(str);

    printf("111:%f\n", d);


    int m, n;
    time_t t;

    n = 5;

    printf("aaa:%d\n", time(&t));

    srand((unsigned) time(&t));


    for (m = 0; m < n; m++) {
        printf("aaa:%d\n", rand() % 50);
    }

    return 0;

}