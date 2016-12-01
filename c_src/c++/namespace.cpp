#include <cstdio>

using namespace std;


namespace diy{
	class Student{
		public:
			char *name;
			int age;
			float score;
		public:
			void say(){
				printf("%s...%d...%f\n", name, age, score);
			}
	};
}

class Book{
	private:
		float price;
	public:
		void setprice(float p1){
			price = p1;
		}
		float getprice(){
			return price;
		}
};

int main(){
	diy::Student s1;
	s1.name = "小明";
	s1.age = 15;
	s1.score = 90.5;
	s1.say();

	float p;
	Book book;
	scanf("%f", &p);
	book.setprice(p);

	printf("price:%f\n", book.getprice());

	return 0;
}
