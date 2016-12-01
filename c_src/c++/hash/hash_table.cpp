//
// Created by yj on 16-11-28.
//
#include "hash_table.h"
#include <malloc.h>
#include <memory.h>


hash_table::hash_table(const int ntablesize) {
    m_nTableSize = ntablesize;
    m_ppTable = (Node **) malloc(sizeof(Node *) * m_nTableSize);
    if (m_ppTable == NULL)
        return;
    m_nTableDataCount = 0;
    memset(m_ppTable, 0, sizeof(Node *) * m_nTableSize);
}

hash_table::~hash_table() {
    free(m_ppTable);
    m_ppTable = NULL;
    m_nTableDataCount = 0;
    m_nTableSize = 0;
}

int hash_table::hashFun(int n) {
    return (n ^ 0xdeadbeef) % m_nTableSize;
}

int hash_table::size() {
    return m_nTableDataCount;
}

bool hash_table::insert(int n) {
    int key = hashFun(n);
    for (Node *p = m_ppTable[key]; p != NULL; p = p->next) {
        if (p->val == n)
            return true;
    }

    Node *pNode = new Node(n);
    if (pNode == NULL) {
        return false;
    }
    pNode->next = m_ppTable[key];
    m_ppTable[key] = pNode;
    m_nTableDataCount++;
    return true;
}

bool hash_table::find(int n) {
    int key = hashFun(n);
    for (Node *pNode = m_ppTable[key]; pNode != NULL; pNode = pNode->next)
        if (pNode->val == n)
            return true;
    return false;
}

void hash_table::insert(int *pfirst, int *plast) {
    for (int *p = pfirst; p != plast; p++) {
        this->insert(*p);
    }
}

