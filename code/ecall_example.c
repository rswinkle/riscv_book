#include <stdio.h>

int main()
{
	int age;
	int height;
	char name[50];
	printf("What's your name? ");
	fgets(name, 50, stdin);

	printf("Hello %s", name);

	printf("How old are you? ");
	scanf("%d", &age);

	printf("Enter your height in inches: ");
	scanf("%d", &height);

	printf("Your age + height = %d\n", age + height);

	return 0;
}
