//
// Created by yj on 16-11-28.
//

#include <iostream>
#include <ctime>
#include <sys/timeb.h>

using namespace std;

class Clock {
    int h;
    int m;
    int s;
public:
    void set(int h1, int m1, int s1) {
        h = h1;
        m = m1;
        s = s1;
    }

    void tick();

    void show();

    void run();
};

void Clock::tick() {
    time_t t = time(NULL);
    while (time(NULL) == t);
    if (--s < 0) {
        s = 59;
        if (--m < 0) {
            m = 59;
            --h < 0;
        }
    }
}

void Clock::show() {
    cout << "\r";
    if (h < 10)cout << 0;
    cout << h << ":";
    if (m < 10)cout << 0;
    cout << m << ":";
    if (s < 10)cout << 0;
    cout << s << endl;
}

void Clock::run() {
    cout << h << ":" << m << ":" << s << endl;
    while (h != 0 || m != 0 || s != 0) {
        tick();
        show();
    }
    cout << endl << "Time out!" << endl;
    cout << "\a";
}

int main() {
    Clock c;
    cout << "请输入倒计时的时间：";
    int h1, m1, s1;
    cin >> h1 >> m1 >> s1;
    cout << h1 << ":" << m1 << ":" << s1 << endl;
    c.set(h1, m1, s1);
    c.run();


    return 0;
}