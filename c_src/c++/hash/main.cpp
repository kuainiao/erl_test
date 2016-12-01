//
// Created by yj on 16-11-28.
//
#include <set>
#include "hash_table.h"
#include <iostream>
#include <ctime>
#include <cstdio>
#include <cstdlib>

using namespace std;

void PrintfContainerElapseTime(char *pszContainerName, char *pszOperator, long lElapsetime) {
    printf("%s 的 %s操作 用时 %ld毫米\n", pszContainerName, pszOperator, lElapsetime);
}

const int MAXN = 5000000, MAXQUERY = 5000000;
int a[MAXN], query[MAXQUERY];

int main() {
    printf("set VS hash_set VS hash_table(简化版) 性能测试\n");
    printf("数据容量 %d个 查询次数 %d次\n", MAXN, MAXQUERY);
    const int MAXNUM = MAXN * 4;
    const int MAXQUERYNUM = MAXN * 4;
    printf("容器中数据范围 [0, %d) 查询数据范围[0, %d)\n", MAXNUM, MAXQUERYNUM);
    printf("--by MoreWindows( http://blog.csdn.net/MoreWindows ) --\n\n");


    int i;
    srand((unsigned int) time(NULL));
    for (i = 0; i < MAXN; i++) {
        a[i] = (rand() * rand()) % MAXNUM;
    }
    srand((unsigned int) time(NULL));

    for (i = 0; i < MAXQUERY; i++) {
        query[i] = (rand() * rand()) % MAXQUERYNUM;
    }

    set<int> nset;
    hash_table nhashtable(MAXN + 123);

    clock_t clockBegin, clockEnd;

    printf("-----插入数据-----------\n");
    clockBegin = clock();
    nset.insert(a, a + MAXN);
    clockEnd = clock();

    printf("set中有数据%ld个\n", nset.size());
    PrintfContainerElapseTime("set", "insert", clockEnd - clockBegin);


    clockBegin = clock();
    for (i = 0; i < MAXN; i++)
        nhashtable.insert(a[i]);
    clockEnd = clock();
    printf("hash_table中有数据%d个\n", nhashtable.size());
    PrintfContainerElapseTime("Hash_table", "insert", clockEnd - clockBegin);


    printf("-----查询数据-----------\n");

    int nFindSuccessedCount = 0, nFindFailCount = 0;
    clockBegin = clock();
    for (i = 0; i < MAXQUERY; i++) {
        if (nset.find(query[i]) != nset.end())
            ++nFindSuccessedCount;
        else
            ++nFindFailCount;
    }
    clockEnd = clock();

    PrintfContainerElapseTime("set", "find", clockEnd - clockBegin);
    printf("查询成功次数： %ld    查询失败次数： %ld\n", nFindSuccessedCount, nFindFailCount);
    nFindSuccessedCount = nFindFailCount = 0;

    clockBegin = clock();
    for (i = 0; i < MAXQUERY; i++) {
        if (nhashtable.find(query[i]))
            ++nFindSuccessedCount;
        else
            ++nFindFailCount;
    }
    clockEnd = clock();
    PrintfContainerElapseTime("hash_table", "find", clockEnd - clockBegin);
    printf("查询成功次数： %ld    查询失败次数： %ld\n", nFindSuccessedCount, nFindFailCount);

    return 0;


}