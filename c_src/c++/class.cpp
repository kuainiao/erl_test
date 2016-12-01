#include <iostream>

using namespace std;

class Student{
		char *name;
		int age;
		float score;
	public:
		Student(char*, int, float);
		void display(Student &);
		void say();
};

Student::Student(char *name, int age, float score){
	this -> name = name;
	this -> age = age;
	this -> score = score;
}

void Student::display(Student &stu){
	cout << stu.name << " age:" << stu.age << " score:" << stu.score << endl;
}

void Student::say(){
	cout << this -> name << " age:" << this -> age << " score:" << this -> score << endl;
}

/*struct Student{
	char *name;
	int age;
	float score;

	Student(char*, int, float);
	void say();
}*/

int main(){

	Student stu("小明", 15, 99.9);

	stu.display(stu);

	return 0;

}

