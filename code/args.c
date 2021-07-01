#include <stdio.h>

int main(int argc, char** argv)
{
	printf("There are %d command line arguments:\n", argc);

	for (int i=0; i<argc; i++) {
		printf("%s\n", argv[i]);
	}

	return 0;
}
