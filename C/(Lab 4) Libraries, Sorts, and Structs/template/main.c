#include <stdio.h>  
#include <stdlib.h>
#include <iomanip>
#include <string.h>

#include <iostream>  
using namespace std;    // two of two, yay!

const int noOfRecords=25;
const char *outFileLoc = "../txt/tplSort_d.txt";

int cmpSurname(int, int, struct employee *);
int cmpDept(int, int, struct employee *);
void ptrPrintToFile(struct employee *, int *);


struct employee{
	int key;	
	char surName[14];
	char givenName[14];
	char dept[24];
	double payRate;
	char eyeColor[8];	
};

template <class MyType>
void TemplateAscendingSort( struct employee *emply, MyType *ptr){
	int i, j;
	MyType temp;

	//Give each record a key
	for(i = 0; i < noOfRecords; i++)	
	{
		emply[i].key = i;
		ptr[i] = i;		
	}

	for(i = 0; i < noOfRecords; i++){
		temp = ptr[i];
		j = i;
		while(j > 0 && cmpDept(ptr[j - 1], temp, emply) > 0){
			ptr[j] = ptr[j - 1];
			j--;
		}
		ptr[j] = temp;
	}
}

int main(){		
	int i, ptr[noOfRecords];
	FILE *inFile = fopen(outFileLoc, "w+"); //Empty export if it exists
	fclose(inFile);

	inFile = fopen("../Lab4.txt", "r");
	if (!inFile) {
		printf("File does not exist\n");
		exit(1);	
	}

	// Create the table
	struct employee empl[noOfRecords];


	for(i = 0; fscanf(inFile, "%s %s %s %lf %s", empl[i].surName, empl[i].givenName, empl[i].dept, &empl[i].payRate, empl[i].eyeColor) != EOF; i++) {
		// Give each entry a key and print to screen		
		empl[i].key = ptr[i] = i;
		

		printf("%-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", empl[i].key, empl[i].surName, empl[i].givenName, empl[i].dept, empl[i].payRate, empl[i].eyeColor);
	}

	// Print the Records to file
	ptrPrintToFile(empl, ptr);

	TemplateAscendingSort(empl, ptr);
	
	// Close
	fclose(inFile);

	// Reprint ordered records
	ptrPrintToFile(empl, ptr);	

	return 0;
}

int cmpSurname(int p, int q, struct employee *emply )  //Compare by name
              {return strcmp(emply[p].surName, emply[q].surName) ; }

int cmpDept(int p, int q, struct employee *emply )  //Compare by Dept
              {return strcmp(emply[q].dept, emply[q].dept); }


void ptrPrintToFile(struct employee *emply, int *ptr){
	int i;
	
	FILE *openFile;		
	openFile = fopen(outFileLoc, "r");	

	if (!openFile) 
		openFile = fopen(outFileLoc, "w+" );
	else	
		openFile = fopen(outFileLoc, "a+" );

	// Print the header
	for (i = 0; i <= 90; i++) fprintf(openFile, "-");
	fprintf(openFile, "\n    Surname       \tGiven name    \tDepartment    \t\tPayRate \tEye Color \n");
	for (i = 0; i <= 90; i++) fprintf(openFile, "-");
	fprintf(openFile, "\n");	
		
	// Print content
	for (i = 0; i < noOfRecords; i++){
		//printf(" %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[i].key, emply[i].surName, emply[i].givenName, emply[i].dept, emply[i].payRate, emply[i].eyeColor);
		fprintf(openFile, " %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[ptr[i]].key, emply[ptr[i]].surName, emply[ptr[i]].givenName, emply[ptr[i]].dept, emply[ptr[i]].payRate, emply[ptr[i]].eyeColor);
	}
	fprintf(openFile, "\f\n");
	printf("\tSuccessfully processed %d records to file (%s).\n", noOfRecords, outFileLoc);
	fclose(openFile);	
}


