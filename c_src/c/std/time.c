//
// Created by yj on 16-11-30.
//

#include <stdio.h>
#include <time.h>

#define BST (+1)
#define CCT (+8)

int main() {
    int m = 0;
    clock_t c_s, c_e, c_t;
    time_t t1, t2, rawtime;
    struct tm *info;
    char buffer[80];

    c_s = clock();
    time(&t1);

    printf("开始一个大循环，start_t = %ld\n", c_s);
    for (int i = 0; i < 100000000; ++i) {
        m = i;
    }

    c_e = clock();
    printf("大循环结束，end_t = %ld\n", c_e);

    c_t = c_e - c_s;

    printf("cpu 占用总时间:%ld\n", c_t);

    time(&t2);
    printf("time:%s", ctime(&t1));


    printf("time:%f", difftime(t2, t1));


    time(&rawtime);
    info = gmtime(&rawtime);

    printf("当前的世界时钟：\n");
    printf("伦敦：%2d:%02d\n", (info->tm_hour + BST) % 24, info->tm_min);
    printf("中国：%2d:%02d\n", (info->tm_hour + CCT) % 24, info->tm_min);

    info = localtime(&rawtime);
    printf("当前本地时间和日期：%s", asctime(info));
    return 0;
}