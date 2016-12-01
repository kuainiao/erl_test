//
// Created by yj on 16-11-24.
//

#include <iostream>
#include <string>

using namespace std;

int main() {
    string s1 = "123456789";
    string s2 = "b";
    string s3 = "5";
    string s4, s5;
    s1.insert(5, s2);
    s4 = s1.erase(7, 7);
    s5 = s1.substr(6, 6);

    int i1, i2, i3, i4, i5;
    i1 = s1.find(s3);
    i2 = s1.find(s3, 3);
    i3 = s1.rfind(s3, 3);
    i4 = s1.rfind(s3, 8);

    i5 = s1.find_first_of(s3);

    cout << "s1:" << s1 << "\ns4=" << s4 << "\ns5=" << s5 << "\ni1" << i1 << "\ni2" << i2 << "\ni3" << i3 << "\ni4"
         << i4 << "\ni5" << i5 << endl;


    string str = "aaabbb我们都有一个家";
    cout << str.size() << endl;
    return 0;
}