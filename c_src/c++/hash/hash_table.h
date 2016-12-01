//
// Created by yj on 16-11-28.
//

#define NULL 0

struct Node {
    int val;
    Node *next;

    Node(int n) {
        this->val = n;
        this->next = NULL;
    }
};

class hash_table {
public:
    hash_table(const int ntablesize);

    ~hash_table();

    bool insert(int n);

    void insert(int *pfirst, int *plast);

    bool find(int n);

    int size();

    int hashFun(int n);

    int m_nTableSize;
    int m_nTableDataCount;
    Node **m_ppTable;
};

