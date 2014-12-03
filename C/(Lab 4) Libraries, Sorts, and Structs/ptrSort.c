#include <stdio.h>
#include <stdlib.h>
#include <string.h>
const int noOfRecords = 25;
char export[] = "txt/ptrSort.txt";

struct employee{
	int key;	
	char surName[14];
	char givenName[14];
	char dept[24];
	double payRate;
	char eyeColor[8];	
};


void swap(struct employee *, int, int);
void bubbleUp(struct employee *);
void straightInsertion(struct employee *);
void pointerSort(struct employee *, int *);
void ptrPrintToFile(struct employee *, int *);
void arraySwap(int [], int, int);

int main(){		
	int i, ptr[noOfRecords];
	
		

	FILE *inFile = fopen(export, "w+"); //Empty export if it exists
	fclose(inFile);

	inFile = fopen("Lab4.txt", "r");
	if (!inFile) {
		printf("File does not exist\n");
		exit(1);	
	}

	// Create the table
	struct employee empl[noOfRecords];


	for(i = 0; fscanf(inFile, "%s %s %s %lf %s", empl[i].surName, empl[i].givenName, empl[i].dept, &empl[i].payRate, empl[i].eyeColor) != EOF; i++) {
		// Give each entry a key and print to screen		
		empl[i].key = ptr[i] = i;
	}

	// Print the Records to file
	ptrPrintToFile(empl, ptr);

	pointerSort(empl, ptr);
	
	// Close
	fclose(inFile);

	// Reprint ordered records
	ptrPrintToFile(empl, ptr);	

	return 0;
}

void pointerSort(struct employee *emply, int *ptr){
	int i, j ;
	int temp;

	//Give each record a key
	for(i = 0; i < noOfRecords; i++)	
	{
		emply[i].key = i;
		ptr[i] = i;		
	}

	for(i = 0; i < noOfRecords; i++){
		temp = ptr[i];
		j = i;
		while(j > 0 && strcmp(emply[ptr[j - 1]].dept, emply[temp].dept) > 0){
			ptr[j] = ptr[j - 1];
			j--;
		}
		ptr[j] = temp;
	}
}



void ptrPrintToFile(struct employee *emply, int *ptr){
	int i;
	
	FILE *openFile;		
	openFile = fopen(export, "r" );	

	if (!openFile) 
		openFile = fopen(export, "w+" );
	else	
		openFile = fopen(export, "a+" );

	// Print the header
	for (i = 0; i <= 90; i++) fprintf(openFile, "-");
	fprintf(openFile, "\n    Surname       \tGiven name    \tDepartment    \t\tPayRate \tEye Color \n");
	for (i = 0; i <= 90; i++) fprintf(openFile, "-");
	fprintf(openFile, "\n");	
		
	// Print content
	for (i = 0; i < noOfRecords; i++){
	//	printf(" %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[i].key, emply[i].surName, emply[i].givenName, emply[i].dept, emply[i].payRate, emply[i].eyeColor);
		fprintf(openFile, " %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[ptr[i]].key, emply[ptr[i]].surName, emply[ptr[i]].givenName, emply[ptr[i]].dept, emply[ptr[i]].payRate, emply[ptr[i]].eyeColor);
	}
	fprintf(openFile, "\f\n");
	printf("\tSuccessfully processed %d records to file (%s).\n", noOfRecords, export);
	fclose(openFile);	
}




