#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

struct Person{
	char *name;
	int age;
	int height;
	int weight;
};


struct Persion *Persion_create(char *name, int age, int height, int weight){
	struct Person *who = malloc(sizeof(struct Person));
	assert(who != NULL);
	printf("name :%p\n", name);
	printf("strdup(name):%p\n", strdup(name));
	who -> name = strdup(name);
	who -> age = age;
	who -> height = height;
	who -> weight = weight;
}


void Persion_destroy(struct Person *who){
	assert(who != NULL);
	free(who -> name);
	free(who);
}


void Persion_print(struct Person *who){
	printf("Name:%s\n", who -> name);
	printf("\t Age:%d\n", who -> age);
	printf("\tHeight:%d\n", who -> height);
	printf("\tWeight:%d\n", who -> weight);
}


int main(int argc, char *argv[]){
	struct Person *p1 = Persion_create("aaa", 1,1,1);
	struct Person *p2 = Persion_create("bbb", 2,2,2);


	printf("aaa is at memory location %p:\n", p1);
	Persion_print(p1);
	printf("bbb is at memory location %p:\n", p2);
	Persion_print(p2);
	
	p1 -> age = 3;
	p1 -> height = 3;
	p1 -> weight = 3;
	Persion_print(p1);

	p2 -> age +=2;
	p2 -> height +=2;
	p2 -> weight +=2;
	Persion_print(p2);

	Persion_destroy(p1);
	Persion_destroy(p2);

	return 0;

}
