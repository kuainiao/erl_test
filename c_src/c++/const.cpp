#include <iostream>

using namespace std;

class Student{
	private:
		char *name;
		float score;
	public:
		Student(char *, float);
		char *getName() const;
		float getScore() const;
		void setName(char *name);
		void setScore(float score);
};

Student::Student(char *name, float score){
	this -> name = name;
	this -> score = score;
}

char *Student::getName() const{
	return name;
}

float Student::getScore() const{
	return name;
}

void Student::setName(char *name){
	this -> name = name;
}
void Student::setScore(float score){
	this -> score = score;
}

int main(){
	const Student s1("小明", 10.1);
	s1.getScore();
	s1.setScore(100.0);
	return 0;
}
