//
// Created by yj on 16-11-29.
//

#define MAXSIZE 100;
#define DataType int;

typedef struct {
    DataType data[MAXSIZE];
    int last;
} SeqList;

SeqList *init_SeqList() {
    SeqList *L;
    L = malloc(sizeof(SeqList));
    L->last = -1;
    return L;
}

int insert_SeqList(SeqList *L, int i, datatype x) {
    int j;
    if (L->last == MAXSIZE
    -1){
    }
}