//
// Created by yj on 16-11-30.
//

#include <stdio.h>
#include <errno.h>
#include <string.h>

extern int errno;

int main() {
    FILE *fp;
    fp = fopen("file.txt", "r");
    if (fp == NULL) {
        fprintf(stderr, "value of errno:%d\n", errno);
        fprintf(stderr, "error opening file:%s\n", strerror(errno));
    } else {
        fclose(fp);
    }
    return 0;
}
