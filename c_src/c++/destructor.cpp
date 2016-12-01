#include <iostream>

using namespace std;

class Student{
	private:
		char *name;
		int age;
		float score;
	public:
		Student(char *, int, float);
	~Student();
	void say();
};

Student::Student(char *name1, int age1, float score1):name(name1),age(age1),score(score1){}
Student::~Student(){
	cout << name << "bye bye" << endl;
}

void Student::say(){
	cout << name << " age:" << age << " score:" << score << endl;
}

int main(){
	Student s1("小明", 15, 50.0);
	s1.say();

	Student s2("李磊", 16, 95);
	s2.say();

	Student s3("王爽", 16, 80.5f);
	s3.say();

	cout<<"main 函数即将运行结束"<<endl;
	   
	return 0;
}

