#include <stdio.h>
#include <string.h>
#include <stdlib.h>



int main()
{
#define ROWS 2
#define COLS 4

	int array[ROWS][COLS] = { { 1, 2, 3, 4 }, { 5, 6, 7, 8 } };
	int array1d[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };

	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			printf("%d ", array[i][j]);
		}
		putchar('\n');
	}


	puts("Now let's prove that it's packed, row-major in memory by just looping through the memory directly\n");

	int* p = &array[0][0];
	for (int i=0; i<ROWS*COLS; i++, p++) {
		printf("%d ", *p);
	}

	puts("\n\nLook at that.  Or this:");
	
	if (!memcmp(array, array1d, 8*sizeof(int))) {
		puts("memcmp(array, array1d, 8*sizeof(int)) == 0\narray and array1d are identical\n");
	}
	
	
	// Now let's look at the common but stupid way to allocate a 2D array
	int** my2darray = malloc(ROWS * sizeof(int*));
	for (int i=0; i<ROWS; i++) {
		my2darray[i] = malloc(COLS * sizeof(int));
		for (int j=0; j<COLS; j++) {
			my2darray[i][j] = i * j;
		}
	}

	// do stuff with it here
	printf("my2darray[1][3] = %d\n", my2darray[1][3]);
	

	for (int i=0; i<ROWS; i++) {
		free(my2darray[i]);
	}
	free(my2darray);

	// compare that with the much much more efficient and cleaner way...
	
	int* array2d = malloc(ROWS*COLS * sizeof(int));
	for (int i=0; i<ROWS; i++) {
		for (int j=0; j<COLS; j++) {
			array2d[i*COLS + j] = i * j;
		}
	}

	printf("array2d[1][3] = %d\n", array2d[1*COLS+3]);

	free(array2d);

	// The higher rows the better the pseudo-2D array gets in comparison regarding
	// performance and not having to allocate and free all those sub-arrays.
	// The difference is even more stark at higher dimensions 3D etc. can you imagine
	// having to allocate all the planes, then all the rows and free them too?
	//
	// If you've ever dealt with images in code you know they're almost always dealt
	// with as a single allocation like above, a pseudo 2D array of pixels



	return 0;
}
