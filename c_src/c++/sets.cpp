//
// Created by yj on 16-11-28.
//

#include <unordered_set>
#include <iostream>
#include <algorithm>

using namespace std;
typedef unordered_set<int> hs_int;

void show_l(hs_int l) {
    hs_int::iterator i;
    for (i = l.begin(); i != l.end(); i++) {
        cout << " " << *i;
    }
    cout << endl;
}

template<typename T1, typename T2, typename T3>
T3 unordered_set_intersection(T1 a1, T1 b1, T2 a2, T2 b2, T3 c) {
    cout << "111" << !(a1 == b1) << endl;
    while (!(a1 == b1)) {
        cout << "aaa" << endl;
        if (!(find(a2, b2, *a1) == b2)) {
            cout << "bbb" << endl;
            *c = *a1;
            ++c;
        }
        ++a1;
    }
    return c;
};


int main() {
    unordered_set<int> hs1, hs2, hs3, hs4, hs5;
    hs1.insert(1);
    hs1.insert(2);
    hs1.insert(3);
    hs2.insert(1);
    hs2.insert(12);
    hs2.insert(13);


    set_union(hs1.begin(), hs1.end(), hs2.begin(), hs2.end(),
              insert_iterator<unordered_set<int>>(hs3, hs3.begin()));
    show_l(hs3);


    unordered_set_intersection(hs1.begin(), hs1.end(), hs2.begin(), hs2.end(),
//                               insert_iterator<unordered_set<int>>(hs4, hs4.begin())
                               inserter(hs4, hs4.begin())
    );

    show_l(hs4);


    set_difference(hs1.begin(), hs1.end(), hs2.begin(), hs2.end(),
                   insert_iterator<unordered_set<int>>(hs5, hs5.begin()));

    show_l(hs5);


    return 0;
}