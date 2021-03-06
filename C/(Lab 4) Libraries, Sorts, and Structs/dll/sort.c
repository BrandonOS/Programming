#include "mySort.h"

void addrPointerSort(struct employee *emply, int *ptr){
	int i, j;
	const int noOfRecords = 25;
	int temp;

	//Give each record a key
	for(i = 0; i < noOfRecords; i++)	
	{
		emply[i].key = i;
		*(ptr + i) = i;		
	}

	//Invoke sort
	for(i = 0; i < noOfRecords; i++){
		temp = *(ptr + i);
		j = i;
		while(j > 0 && strcmp( emply[ *(ptr + (j -1)) ].dept, emply[temp].dept) > 0){
			*(ptr + j)  = *(ptr + (j - 1));
			j--;
		}
		*(ptr + j)  = temp;
	}
}

