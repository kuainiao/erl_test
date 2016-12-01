#include <iostream>

using namespace std;

void swap(int *a, int *b);
int & valplus(int &a);


int main(){
	int a = 10;
	int &b = a;
	cout << a << " " << b << endl;
	cout << &a << " " << &b << endl;


	int n1 = 10, n2;
	n2 = valplus(n1);
	cout << n1 << " " << n2 << endl;

	
	int *p1 = &a, *p2 = &n2;

	swap(*p1, *p2);
	cout << n1 << " " << n2 << endl;

	

	return 0;

}

void swap(int *a, int *b){
	int temp;
	temp = *a;
	*a = *b;
	*b = temp;

}

int & valplus(int &a){
	a = a+5;
	return a;
}
