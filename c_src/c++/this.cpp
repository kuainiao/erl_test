#include <iostream>

using namespace std;

class Student{
	private:
		char *name;
		int age;
		float score;
		static int num;
	public:
		Student(char *, int, float);
		void setname(char *);
		void setage(int);
		void setscore(float);
		void say();
		void print_this();

};

int Student::num = 0;

Student::Student(char *name, int age, float score){
	this -> name = name;
	this -> age = age;
	this -> score = score;
	num++;
}

void Student::setname(char *name){
	this -> name = name;
}
void Student::setage(int age){
	this -> age = age;
}
void Student::setscore(float score){
	this -> score = score;
}
void Student::say(){
	cout << this -> name << " age:" << this -> age << " score:" << this -> score <<  " num:" << this -> num <<endl;
}
void Student::print_this(){
	cout << this << endl;
}

int main(){
	/*Student s1, *p1 = &s1;
	s1.setname("aa");
	s1.setage(15);
	s1.setscore(15.5);
	s1.say();

	s1.print_this();
	cout << p1 << endl;

	Student s2, *p2 = &s2;
	s2.print_this();
	cout << p2 << endl;*/

	Student s1("小明", 15, 90);
	Student s2("李磊", 16, 80);
	Student s3("张华", 16, 99);
	Student s4("王康", 14, 60);

	//(new Student("小明", 15, 90))->say();
    //(new Student("李磊", 16, 80))->say();
    //(new Student("张华", 16, 99))->say();
    //(new Student("王康", 14, 60))->say();
	
	s1.say();
	s2.say();
	s3.say();
	s4.say();

	return 0;
}
