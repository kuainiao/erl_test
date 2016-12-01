//
// Created by yj on 16-11-24.
//

#include <iostream>

using namespace std;

class complex {
private:
    double real;
    double imag;
public:
    complex() : real(0.0), imag(0.0) {}

    complex(double a, double b) : real(a), imag(b) {}

    friend complex operator+(const complex &A, const complex &B);

    friend complex operator-(const complex &A, const complex &B);

    friend complex operator*(const complex &A, const complex &B);

    friend complex operator/(const complex &A, const complex &B);

    friend istream &operator>>(istream &in, complex &A);

    friend ostream &operator<<(ostream &out, complex &A);

    void display() const;
};

complex operator+(const complex &A, const complex &B) {
    complex C;
    C.real = A.real + B.real;
    C.imag = A.imag + B.imag;
    return C;
}

complex operator-(const complex &A, const complex &B) {
    complex C;
    C.real = A.real - B.real;
    C.imag = A.imag - B.imag;
    return C;
}

complex operator*(const complex &A, const complex &B) {
    complex C;
    C.real = A.real * B.real - A.imag * B.imag;
    C.imag = A.imag * B.real + A.real * B.imag;
    return C;
}

complex operator/(const complex &A, const complex &B) {
    complex C;
    double square = A.real * A.real + A.imag * A.imag;
    C.real = (A.real * B.real + A.imag * B.imag) / square;
    C.imag = (A.imag * B.real - A.real * B.imag) / square;
    return C;
}

istream &operator>>(istream &in, complex &A) {
    in >> A.real >> A.imag;
    return in;
}

ostream &operator<<(ostream &out, complex &A) {
    out << A.real << "+" << A.imag << "i";
    return out;
}

void complex::display() const { cout << "real:" << real << " imag:" << imag << endl; }


int main() {
    complex c1, c2, c3;
    cin >> c1 >> c2;

    c3 = c1 + c2;
    cout << "c1+c2=" << c3 << endl;

    c3 = c1 - c2;
    cout << "c1 - c2 = " << c3 << endl;

    c3 = c1 * c2;
    cout << "c1 * c2 = " << c3 << endl;

    c3 = c1 / c2;
    cout << "c1 / c2 = " << c3 << endl;

    c3.display();
    return 0;
}