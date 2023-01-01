#include <stdio.h>


// This compiles with gcc, uses non-standard extension
// https://gcc.gnu.org/onlinedocs/gcc/Labels-as-Values.html 

int main()
{

	// jump table
	void* switch_table[] =
	{ &&a_label, &&b_label, &&c_label, &&d_label, &&default_label, &&f_label };

	printf("Enter your grade (capital): ");
	int grade = getchar();
	grade -= 'A';  // shift to 0

	if (grade < 0 || grade > 'F'-'A')
		goto default_label;

	goto *switch_table[grade];

a_label:
	puts("Excellent job!");
	goto end_switch;

b_label:
	puts("Good job!");
	goto end_switch;

c_label:
	puts("At least you passed?");
	goto end_switch;

d_label:
	puts("Probably should have dropped it...");
	goto end_switch;

f_label:
	puts("Did you even know you were signed up for the class?");
	goto end_switch;

default_label:
	puts("You entered an invalid grade!");


end_switch:


	return 0;
}
