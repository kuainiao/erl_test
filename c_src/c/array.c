//
// Created by yj on 16-11-29.
//

#include <stdio.h>


int max(int a, int b) {
    return a > b ? a : b;
}

int main() {
    int arr[] = {1, 100, 500, 30, 200};
    int len = sizeof(arr) / sizeof(int);
    int i;
    for (i = 0; i < len; i++) {
        printf("%d ", *(arr + i));
    }
    printf("\n");


    char str[] = "test1";

    char *pstr = str;
    pstr = "aaa1";
    printf("%s\n", pstr);

    str[2] = 'A';
    printf("%s\n", str);


    int a[3][4] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    int (*p)[4];
    int j;
    p = a;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 4; j++) {
            printf("%d  ", *(*(p + i) + j));
        }
        printf("\n");
    }


    int x, y, maxval;
    int (*pmax)(int, int) = max;
    printf("Input two numbers:");
    scanf("%d %d", &x, &y);
    maxval = (*pmax)(x, y);
    printf("Max value:%d\n", maxval);

    return 0;
}