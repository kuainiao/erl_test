//
// Created by yj on 16-11-30.
//

#include <stdio.h>


int read_file() {
    FILE *fp;
    int c;
    int n = 0;

    fp = fopen("file.txt", "r");
    while (1) {
        c = fgetc(fp);
        if (feof(fp)) {
            break;
        }
        printf("%c", c);
    }
    fclose(fp);
    return 0;
}

#define nmemb 3
struct test {
    char name[20];
    int size;
} s[nmemb];

int main() {
    FILE *fp;

    fp = fopen("file.txt", "r");

    fread(s, 3, nmemb, fp);

    fclose(fp);

    for (int i = 0; i < nmemb; i++) {
        printf("name[%d] = %-20s:size[%d]=%d\n", i, s[i].name, i, s[i].size);
    }


    read_file();

    return 0;
}