//
// Created by yj on 16-11-24.
//

#include <iostream>
#include <string>

using namespace std;

template<typename T, int N>
class String {
private:
    T p;
    int len;
public:
    String() {}

    String(T p) : p(p), len(N) {}

    void set_p(T p);

    T get_p() { return p; };

    int length() { return len; }

};

template<typename T, int N>
void String<T, N>::set_p(T p) {
    this->p = p;
}

int main() {
    string p = "123";
    String<string, 10> a(p);
    cout << a.length() << endl;
    cout << a.get_p() << endl;
    return 0;
}