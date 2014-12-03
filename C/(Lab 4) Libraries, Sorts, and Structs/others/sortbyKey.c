#include <stdio.h>
#include <stdlib.h>
#include <string.h>
const int noOfRecords = 25;

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
void printToFile(struct employee *, int);

int main(){		
	int i;

	FILE *inFile = fopen("Lab4.txt", "r");
	if (!inFile) {
		printf("File does not exist\n");
		exit(1);	
	}

	// Create the table
	struct employee empl[noOfRecords];


	// Populate the table
	int tableSize = sizeof(empl)/sizeof(struct employee);

	for(i = 0; fscanf(inFile, "%s %s %s %lf %s", empl[i].surName, empl[i].givenName, empl[i].dept, &empl[i].payRate, empl[i].eyeColor) != EOF; i++) {
		// Give each entry a key and print to screen		
		empl[i].key = (i+1);
	//	printf(" %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", empl[i].key, empl[i].surName, empl[i].givenName, empl[i].dept, empl[i].payRate, empl[i].eyeColor);
	}

	// Print the Records to file
	printToFile(empl, 0);


	straightInsertion(empl);
	
	
	// Close
	fclose(inFile);

	// Reprint ordered records
	printToFile(empl, 0);
	

	return 0;
}


void straightInsertion(struct employee *emply){
	int i, j;
	struct employee temp;

	for(i = 1; i < noOfRecords; i++){
		temp = emply[i];
		j = i;
		while (j > 0 && strcmp(emply[j - 1].dept, temp.dept) > 0){
			emply[j]= emply[j - 1];
			j--;
		}
		emply[j] = temp;
	}


}

void bubbleUp(struct employee *emply){
	int i, j;
	for(i = noOfRecords - 1; i > 0; i--)	
		for(j = 0; j < i; j++)
			if( strcmp(emply[j].dept, emply[j + 1].dept) > 0)
				swap(emply, j, (j+1));		
}

void swap(struct employee *emply, int i, int j){
	struct employee temp;
	temp = emply[i];
	emply[i] = emply[j];
	emply[j] = temp;
}

void printToFile(struct employee *emply, int j){
	int i;
	
	char fileName[20];
	FILE *openFile;
	
	// Create a new file? ( => 1)
	if (j == 1) 
		openFile = fopen(fileName, "w+" );
	else
		openFile = fopen(fileName, "a+" );
	
	
	// Print the header
	for (i = 0; i <= 90; i++) printf("-");
	printf("\n    Surname       \tGiven name    \tDepartment    \t\tPayRate \tEye Color \n");
	for (i = 0; i <= 90; i++) printf("-");
	printf("\n");	
		
	// Print content
	for (i = 0; i < noOfRecords; i++){
		fprintf(openFile, " %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[i].key, emply[i].surName, emply[i].givenName, emply[i].dept, emply[i].payRate, emply[i].eyeColor);
	}
	printf("\tSuccessfully printed %d records to file (%s).\n", noOfRecords, fileName);
	printf("Size is: %d\t", noOfRecords);	 
	fclose(openFile);
}





