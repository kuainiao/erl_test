//
// Created by yj on 16-11-24.
//
#include <iostream>

using namespace std;

template<typename T>
T sum(T x, T y) {
    T temp = x + y;
    return temp;
}

template<typename T>
T max(T a, T b, T c) {
    if (a > b) a = b;
    if (a > c) a = c;
    return a;
}

int main() {
    int x = 10, y = 20;
    cout << sum(10, 20) << endl;

    cout << max(10, 11, 12) << endl;
    return 0;
}