//
// Created by yj on 16-11-29.
//

#include <iostream>

using namespace std;


int main() {
//    int c;
//    cout << "enter a sentence:" << endl;
//    while ((c = cin.get()) != EOF) {
//        cout.put(c);
//    }


    char ch[20];
    cout << "enter a sentence: " << endl;
    cin >> ch;
    cout << "the string read with cin is: " << ch << endl;
    cin.getline(ch, 20, '/');

    cout << "this second part is: " << ch << endl;
    cin.getline(ch, 20);
    cout << "the third part is:" << ch << endl;
    return 0;
}
