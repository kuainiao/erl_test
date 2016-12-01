#include <stdio.h>

int main(){
	struct Student{
		char *name;
		int age;
		float score;
	};

	struct Student s1;
	s1.name = "小明";
	s1.age = 15;
	s1.score = 92.5;

	printf("%s的年龄是：%d, 成绩是%f\n", s1.name, s1.age, s1.score);

	return 0;
}

