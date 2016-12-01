//
// Created by yj on 16-11-24.
//

#include <iostream>
#include <string>

using namespace std;

class Array {
private:
    int length;
    int *num;
public:
    Array() : length(0), num(NULL) {}

    Array(int n);

    int &operator[](int);

    int getlength() const { return length; }
};

Array::Array(int n) {
    num = new int[n];
    length = n;
}

int &Array::operator[](int i) {
    if (i < 0 || i >= length) {
        throw string("out of bounds");
    } else {
        return num[i];
    }
}

int main() {
    Array A(5);
    int i;
    try {
        for (i = 0; i < A.getlength(); i++) {
            A[i] = i;
        }
        for (i = 0; i < 6; i++) {
            cout << A[i] << endl;
        }
    } catch (string s) {
        cerr << s << ", i=" << i << endl;
    }
    return 0;
}