#include <stdio.h>
#include <math.h>

double sumFloats( float a[], int size_ ){
	int i, j, pos;
	float smallest, temp;
	double sum = 0.0;
	printf("\nUnsorted");
	for(i = 0; i < size_; i++)		// Print out the unsorted list
		printf("\n\t %16.7f ", a[i]);
		

	for(i = 0; i < size_ - 1; i++){		// Sorting algorithm
		smallest = a[i];	
		for (j = i; j < size_; j++){	
			if (smallest > a[j]){
				smallest = a[j];
				pos = j;							
			}
		}			
		temp = a[i];
		a[i] = smallest;
		a[pos] = temp;	
	}

	printf("\nSorted");			// Print out the Sorted list (while calculating total)
	for(i = 0; i < size_; i++){
		printf("\n\t %16.7f ", a[i]);
		sum += a[i];	
	}
	printf("\n   Sum is %.8f\n", sum);
	return sum;
}



