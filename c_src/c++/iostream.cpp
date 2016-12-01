#include <iostream>

using namespace std;

int main(){
	int x;
	float y;
	cout << "input an num" << endl;
	cin >> x >> y;
	cout << "int num is x=" << x << endl;
	//cout << "input an float" << endl;
	//cin >> y;
	cout << "float num is y=" << y << endl;


	int sum = 0, val = 0;
	cout << "input " << endl;
	while(cin >> val){
		sum += val;
		cout << "input num:" << endl;
	}
	cout << "all num is:" << sum << endl;

	return 0;

}

