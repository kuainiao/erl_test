//
// Created by yj on 16-11-24.
//

#include <iostream>

using namespace std;

class Book {
private:
    double price;
    int *bookmark;
    int num;
public:
    Book() : price(0.0), bookmark(NULL), num(0){};

    Book(double, int *, int);

    void set_bookmark(int, int);

    void display();
};

Book::Book(double price1, int *bookmark1, int num1) {
    this->price = price1;
    this->num = num1;
    int *temp = new int[num1];
    for (int i; i < num1; i++) {
        temp[i] = bookmark1[i];
    };
    this->bookmark = temp;
}

void Book::set_bookmark(int index, int page) {
    if (index > num - 1) {
        cout << "out of []" << endl;
    } else {
        bookmark[index] = page;
    }
}

void Book::display() {
    cout << "price:" << price << endl;
    cout << "bookmarks num:" << num << endl;
    for (int i = 0; i < num; i++) {
        cout << bookmark[i] << endl;
    }
}


int main() {
    int mark[5] = {1, 3, 5, 7, 9};
    Book java, cpp(1.1, mark, 5);

    java = cpp;
    java.set_bookmark(3, 100);
    cpp.display();
    java.display();
    return 0;
}
