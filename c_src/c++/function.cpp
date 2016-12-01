#include <iostream>

using namespace std;

int max(int, int, int);
double max(double, double, double);
long max(long, long, long);

int main(){
	int i1,i2,i3,i_max;
	cin >> i1 >> i2 >> i3;
	i_max = max(i1, i2, i3);
	cout << "i_max=" << i_max << endl;

	double d1, d2, d3, d_max;
	cin >> d1 >> d2 >> d3;
	d_max = max(d1, d2, d3);
	cout << "d_max=" << d_max << endl;

	long g1, g2, g3, g_max;
	cin >> g1 >> g2 >> g3;
	g_max = max(g1, g2, g3);
	cout << "g_max=" << g_max << endl;
}

int max(int a, int b, int c){
	if(b>a) a=b;
	if(c>a) a=c;
	return a;
}

double max(double a, double b, double c){
	if(b>a) a=b;
	if(c>a) a=c;
	return a;
}

long max(long a, long b, long c){
	if(b>a) a=b;
	if(c>a) a=c;
	return a;
}
