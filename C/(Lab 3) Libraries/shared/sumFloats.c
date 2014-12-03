#include <stdio.h>

double sumFloats( float a[], int size_ ){
	int i, j, smallest;
	float temp;
	double sum = 0.0;

	for(i = 0; i < size_-1; i++){		// Sorting algorithm
		smallest = i;	
		for (j = i; j < size_ ; j++){	
			if (a[smallest] > a[j])
				smallest = j;							
			
		}			
		temp = a[i];
		a[i] = a[smallest];
		a[smallest] = temp;	
	}
		
	for(i = 0; i < size_; i++)	
		sum += a[i];	
	
	return sum;
}
