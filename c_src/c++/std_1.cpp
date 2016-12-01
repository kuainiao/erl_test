//
// Created by yj on 16-11-24.
//

#include <stdlib.h>
#include <map>
#include <algorithm>
#include <iostream>
#include <list>

using namespace std;

typedef map<int, int *> m_iip;
typedef map<int, char *> m_icp;

typedef list<int> listInt;

typedef list<int> listChar;

class f_c {
    int _i;
public:
    f_c(int i) : _i(i) {}

    void operator()(m_iip::value_type ite) {
        cout << _i++ << "\t" << ite.first << " shi" << endl;
    }

    void operator()(m_icp::value_type ite) {
        cout << _i++ << "\t" << ite.first << " yan" << endl;
    }
};


void put_list(listInt list, char *name) {
    listInt::iterator plist;
    cout << "The contents of " << name << " : ";
    for (plist = list.begin(); plist != list.end(); plist++)
        cout << *plist << " ";
    cout << endl;
}

int main() {
    listInt list1;

    listInt list2(10, 6);

    listInt list3(list2.begin(), --list2.end());

    listInt::iterator i;

    put_list(list1, "list1");
    put_list(list2, "list2");
    put_list(list3, "list3");

    list1.push_back(2);
    list1.push_back(4);

    cout << "lists1.push_back(2) and list1.push_bakc(4):" << endl;
    put_list(list1, "list1");

    list1.push_front(5);
    list1.push_front(7);
    cout << "front(5) and front(7):" << endl;
    put_list(list1, "list1");

    list1.insert(++list1.begin(), 3, 9);
    cout << "list1.insert(list1.begin(), 3, 9):" << endl;
    put_list(list1, "list1");

    cout << "list1.front() = " << list1.front() << endl;
    cout << "list1.back() = " << list1.back() << endl;

    list1.pop_front();
    list1.pop_back();
    cout << "list1.pop_front() and list1.pop_back():" << endl;
    put_list(list1, "list1");

    list1.erase(++list1.begin());
    cout << "list1.erase(++list1.begin()):"<< endl;
    put_list(list1, "list1");


    return 0;

}

