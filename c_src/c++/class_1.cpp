//
// Created by yj on 16-11-24.
//

#include <iostream>

using namespace std;

class People {
protected:
    char *name;
    int age;
public:
    People(char *, int);

    ~People();

    void set_name(char *);

    void set_age(int);

    void display();
};

People::People(char *name, int age) : name(name), age(age) {
    cout << "People init" << endl;
}

People::~People() {
    cout << "People 销毁" << endl;
}

void People::set_name(char *name1) {
    name = name1;
}

void People::set_age(int age1) {
    age = age1;
}

void People::display() {
    cout << name << " age:" << age << endl;
}

class Student : public People {
private:
    using People::display;


public:
    using People::name;
    using People::age;
    float score;

    Student(char *, int, float);

    ~Student();

    void display1();
};

Student::Student(char *name, int age, float score) : People(name, age) {
    cout << "Student init" << endl;
    this->score = score;
}

Student::~Student() {
    cout << "Student 销毁" << endl;
}

void Student::display1() {
    this->display();
    cout << "score:" << score << endl;
}

class A {
public:
    int m;

    A(int m) : m(m) {}

    void a() { cout << "A::a()" << endl; }

    virtual void c() { cout << "A::c()" << endl; }

    virtual void display() { cout << "A.m = " << m << endl; }
};

class B : public A {
public:
    int n;

    B(int n) : A(n) {}

    void a() { cout << "B::a()" << endl; }

    virtual void c(int n) { cout << "B.c(int n)" << n << endl; }

    virtual void display() { cout << "B.n = " << n << endl; }

    int d() { cout << "B:d()" << endl; }
};

int main() {
    Student s("小明", 15, 99.9);
//    s.display1();
    s.name = "aa";
    s.age = 11;
//    s.display1();

    B *p = new B(1);
    p->display();

    p->a();
    p->d();
    p -> c(0);

    return 0;
}
