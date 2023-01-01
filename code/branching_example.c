#include <stdio.h>

int main()
{
	int score;
	char letter_grade;
	printf("Enter your score: ");
	scanf("%d", &score);
	if (score >= 90) {
		letter_grade = 'A';
	} else if (score >= 80) {
		letter_grade = 'B';
	} else if (score >= 70) {
		letter_grade = 'C';
	} else if (score >= 60) {
		letter_grade = 'D';
	} else {
		letter_grade = 'F';
	}
	printf("You got a %c\n", letter_grade);
	return 0;
}
