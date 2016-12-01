//
// Created by yj on 16-11-24.
//

#include <iostream>

using namespace std;

template<typename M, typename N>
class point {
private:
    M x;
    N y;
public:
    point() : x(0), y(0) {}

    point(M x, N y) : x(x), y(y) {}

    void set_xy(M x, N y);

    M get_x();

    N get_y();
};

template<typename M, typename N>
void point<M, N>::set_xy(M x, N y) {
    this->x = x;
    this->y = y;
}

template<typename M, typename N>
M point<M, N>::get_x() {
    return x;
}

template<typename M, typename N>
N point<M, N>::get_y() {
    return y;
}

int main() {
    int a = 10;
    float b = 12.3;

    point<int, float > p(a, b);
    cout << p.get_x() << endl;
    cout << p.get_y() << endl;
    return 0;
}