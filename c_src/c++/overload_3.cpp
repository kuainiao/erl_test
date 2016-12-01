//
// Created by yj on 16-11-24.
//

#include <iostream>
#include <iomanip>

using namespace std;

class stopwatch {
private:
    int min;
    int sec;
public:
    stopwatch() : min(0), sec(0) {}

    void setzero() { min = 0, sec = 0; }

    stopwatch run();

    stopwatch operator++();

    stopwatch operator++(int);

    friend ostream &operator<<(ostream &, const stopwatch &);
};

stopwatch stopwatch::run() {
    ++sec;
    if (sec == 60) {
        min++;
        sec = 0;
    }
    return *this;
}

stopwatch stopwatch::operator++() {
    return run();
}

stopwatch stopwatch::operator++(int n) {
    stopwatch s = *this;
    run();
    return s;
}

ostream &operator<<(ostream &out, const stopwatch &s) {
    out << setfill('0') << setw(2) << s.min << ":" << setw(2) << s.sec;
    return out;
}

int main() {
    stopwatch s1, s2;

    s1 = s2++;
    cout << "s1:" << s1 << endl;
    cout << "s2:" << s2 << endl;
    s1.setzero();
    s2.setzero();

    s1 = ++s2;
    cout << "s1:" << s1 << endl;
    cout << "s2:" << s2 << endl;
    return 0;
}