//
// Created by yj on 16-11-28.
//

#include <list>
#include <iostream>
#include <deque>
#include <algorithm>

using namespace std;

typedef list<int> list_int;

void show_l(list_int l) {
    list_int::iterator i;
    for (i = l.begin(); i != l.end(); i++) {
        cout << " " << *i;
    }
    cout << endl;
}

int main() {
    list_int l = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
    show_l(l);

//    list_int::iterator i;

    for (list_int::reverse_iterator ri = l.rbegin(); ri != l.rend(); ri++) {
        cout << " " << *ri;
    }
    cout << endl;


    for (auto it = l.cbegin(); it != l.cend(); it++) {
        cout << " " << *it;
    }
    cout << endl;

    for (auto rit = l.crbegin(); rit != l.crend(); rit++) {
        cout << " " << *rit;
    }
    cout << endl;

    cout << "l.empty() : " << l.empty() << endl;
    cout << "l.size() : " << l.size() << endl;
    cout << "l.max_size() : " << l.max_size() << endl;
    cout << "l.front() : " << l.front() << endl;
    cout << "l.back() : " << l.back() << endl;

    l.assign(l.begin(), l.end());
    show_l(l);
    cout << "l.size() : " << l.size() << endl;
    int ints[] = {11, 12, 13};
    l.assign(ints, ints + 3);
    show_l(l);
    cout << "l.size() : " << l.size() << endl;

    l.emplace_front(15);
    show_l(l);

    l.push_front(11);
    show_l(l);

    l.pop_front();
    show_l(l);

    l.emplace_back(17);
    show_l(l);

    l.push_back(18);
    show_l(l);

    l.pop_back();
    show_l(l);

    l.emplace(l.begin(), 19);
    show_l(l);

    l.insert(l.end(), 20);
    show_l(l);

    l.erase(l.begin());
    show_l(l);

    list_int l2 = {21, 22, 23};
    l.swap(l2);
    show_l(l);
    cout << "l2 " << endl;
    show_l(l2);


    l.resize(5);
    show_l(l);
    l.resize(8, 100);
    show_l(l);
    l.resize(10);
    show_l(l);

    l.clear();
    show_l(l);

    show_l(l2);
    l.splice(l.begin(), l2);
    show_l(l);
    show_l(l2);

    list_int::iterator it;
    it = l.begin();
    advance(it, 2);

    l.splice(l.begin(), l, it, l.end());
    show_l(l);
    l2 = {1, 2, 3};

    cout << "l > l2 " << (l > l2) << endl;
    cout << "l < l2 " << (l < l2) << endl;


    return 0;

}