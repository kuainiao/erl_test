#include <iostream>
#include <cstdlib>

using namespace std;

class Demo{
	private:
		double n;
		double m;
		int i;
	public:
		Demo();
		~Demo();
};

Demo::Demo(){
	cout << "Constructor" << endl;
}

Demo::~Demo(){
	cout << "Destructor" << endl;
}

void func(){
	Demo *p = new Demo;
}

int main(){
	cout << "------- new Demo-----" << endl;

	Demo *p1 = new Demo();
	Demo *p2 = new Demo[5];

	cout << "-------malloc--------" << sizeof(Demo) << endl;

	Demo *p3 = (Demo *)malloc(sizeof(Demo));

	cout << "-----------del Demo-------" << endl;

	delete p1;
	delete [] p2;

	cout << "------free-----------" << endl;

	free(p3);

	return 0;
}

