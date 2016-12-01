//
// Created by yj on 16-11-24.
//

#include <iostream>
#include <string>

using namespace std;

char get_char(const string &, int) throw(int, exception);

int main() {
    string str = "c plus plus";

    try {
        cout << get_char(str, 2) << endl;
        cout << get_char(str, 100) << endl;
    } catch (int e) {
        if (e == 1) {
            cout << "Index underflow!" << endl;
        } else if (e == 2) {
            cout << "Index overflow!" << endl;
        }
    }
    return 0;
}

char get_char(const string &str, int index) throw(int, exception) {
    int len = str.length();
    if (index < 0) {
        throw 1;
    }
    if (index >= len)
        throw 2;

    return str[index];
}