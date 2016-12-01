#include <iostream>

using namespace std;

class Student{
	private:
		char *name;
		int age;
		float score;
	public:
		Student(char *, int, float);
		void say();
		
};


Student::Student(char *name1, int age1, float score1){
	name = name1;
	age = age1;
	score = score1;
}

void Student::say(){
	cout << name << "age:" << age << ", score:" << score << endl;
}

int main(){
	Student stu("小明", 25, 20.5);
	stu.say();

	return 0;
}

