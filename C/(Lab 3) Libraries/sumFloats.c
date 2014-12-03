#include <stdio.h>
#include <math.h>

double sumFloats( float a[], int size_ ){
	int i, j, pos;
	float smallest, temp;
	double sum = 0.0;		

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

	return sum;
}



