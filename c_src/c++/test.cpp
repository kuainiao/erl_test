#include <iostream>
#include <typeinfo>
//#include <fiostream>

using namespace std;


template <class T> T GetMax (T a, T b){
	T result;
	result = (a>b)?a:b;
	return (result);
}

class CDummy{ };

int main() {
	CDummy* t1,t2;
	cout << "t1 typeid:" << typeid(t1).name() << "\n";
	cout << "t2 typeid:" << typeid(t2).name() << "\n";

	int i = 5, j = 6, k;
	long l = 10, m = 5, n;
	k = GetMax(i, j);
	n = GetMax(l, m);

	float a = 1.2;
	double b = 2.4;
	char c = 'a';
	cout << k*c+a+b << endl;
	cout << n << endl;

	cout << "This is the line number " 
	     << __LINE__;
	cout << " of file " << __FILE__ 
	     << ".\n";
    cout << "Its compilation began " 
	     << __DATE__;
	cout << " at " << __TIME__ << ".\n";
	cout << "The compiler gives a "
	     <<"__cplusplus value of " 
	     << __cplusplus;


	//ofstream examplefile ("example.txt");

    //if (examplefile.is_open()) {
	//	examplefile << "This is a line.\n";
	//	examplefile << "This is another line.\n";
	//	examplefile.close();
	//}

	return 0;
}

