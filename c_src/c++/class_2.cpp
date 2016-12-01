//
// Created by yj on 16-11-24.
//

#include <iostream>

using namespace std;

class Troops {
public:
    virtual void fight() { cout << "Troops fight" << endl; }

    virtual ~Troops() { cout << "Troops destructor" << endl; }
};

class Army : public Troops {
public:
    void fight() { cout << "Army fight" << endl; }
    ~Army() { cout << "Army destructor" << endl; }
};

class _99A : public Army {
public:
    void fight() { cout << "_99A fight" << endl; }
    ~_99A() { cout << "_99A destructor" << endl; }
};

class AirForce : public Troops {
public:
    void fight() { cout << "AirForce fight" << endl; }
    ~AirForce() { cout << "AirForce destructor" << endl; }
};

class J_20 : public AirForce {
public:
    void fight() { cout << "J_20 fight" << endl; }
    ~J_20() { cout << "J_20 destructor" << endl; }
};

int main() {
    Troops *p = new Troops;
    p->fight();
    delete (p);

    p = new Army;
    p->fight();
    delete (p);

    p = new _99A;
    p->fight();
    delete (p);

    p = new AirForce;
    p->fight();
    delete (p);

    p = new J_20;
    p->fight();
    delete (p);

    return 0;
}