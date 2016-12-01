//
// Created by yj on 16-11-30.
//

#include <stdio.h>
#include <locale.h>
#include <time.h>

int main() {
    time_t currtime;
    struct tm *timer;
    char buffer[80];

    time(&currtime);
    timer = localtime(&currtime);

    printf("locale is :%s\n", setlocale(LC_ALL, "en_GB"));
    strftime(buffer, 80, "%c", timer);
    printf("Data is:%s\n", buffer);


    printf("locale is:%s\n", setlocale(LC_ALL, "de_DE"));
    strftime(buffer, 80, "%c", timer);
    printf("Date is:%s\n", buffer);

    return 0;

}