#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include "mySort.h"

const int noOfRecords = 25;
char export[] = "../txt/addrPtrSort.txt";

int main(){
	// DLL Initialization	
	void *handle;
	char *err;

	void (*ptrSort)(struct employee *, int *);
	
	handle = dlopen("libmyLib.so", RTLD_LAZY);
	if (handle == (void *)0){
		fputs(dlerror(), stderr);
		exit(-1);	
	}

	ptrSort = dlsym(handle, "addrPointerSort"); //
	err = dlerror();
	if(err != NULL){
		fputs(err, stderr);
		exit(-1);
	}
	
	int i, ptr[noOfRecords];

	FILE *inFile = fopen(export, "w+"); //Empty export if it exists
	fclose(inFile);

	inFile = fopen("../Lab4.txt", "r");
	if (!inFile) {
		printf("File does not exist\n");
		exit(1);	
	}

	// Create the table
	struct employee empl[noOfRecords];


	for(i = 0; fscanf(inFile, "%s %s %s %lf %s", empl[i].surName, empl[i].givenName, empl[i].dept, &empl[i].payRate, empl[i].eyeColor) != EOF; i++) {
		// Give each entry a key	
		empl[i].key = ptr[i] = i;
		}
	

	// Print the Records to file
	ptrPrintToFile(empl, ptr);

	addrPointerSort(empl, ptr);
	
	

	// Reprint ordered records
	ptrPrintToFile(empl, ptr);	

	// Close
	fclose(inFile);	
	dlclose(handle);


	return 0;
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
		fprintf(openFile, " %-2d %-12s \t%-10s \t%-21s \t%-5.2f \t\t%-8s \n", emply[*(ptr + i)].key, emply[*(ptr + i)].surName, emply[*(ptr + i)].givenName, emply[*(ptr + i)].dept, emply[*(ptr + i)].payRate, emply[*(ptr + i)].eyeColor);
	}
	fprintf(openFile, "\f\n");
	printf("\tSuccessfully processed %d records to file (%s).\n", noOfRecords, export);
	fclose(openFile);	
}




