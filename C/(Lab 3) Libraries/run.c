#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "myLib.h"

void checkForFile(char[]);

int main(){
	float radius, surface, volume;
	char outFile[24] = "";

	printf("Please enter name of report file to be generated (max 20 characters): ");
	scanf("%s", outFile);
	strcat (outFile,".txt");
	checkForFile(outFile);

	FILE *openFile = fopen( outFile, "w+" );	
	// Sphere
	radius = 7.583;					
	sphere(radius, &surface, &volume);
	printf("The surface area of a sphere is: %.2f\nThe volume is %.2f\n", surface, volume);
	fprintf(openFile, "The surface area of a sphere is: %.2f\nThe volume is %.2f\n", surface, volume);

	// Cylinder
	radius = 13.5 ;
	float height = 6.71;
	printf("The volume of a cylinder is %.2f\n", volCylinder(radius, height));
	fprintf(openFile, "The volume of a cylinder is %.2f\n", volCylinder(radius, height));

	// Array
	float digits[8]  = { 0.3476789, 100400.8, 0.0000099, 1.343567, 78.34567, 1678.567, 997999.6, 0.0000009 };
	int i, size_  = 8;	
//	for(i = 0; i < 8; i++){
//		printf("Enter floating point (%d): ", (i + 1));
//		scanf("%f", &digits[i]);
//	}
		
	printf("\nUnsorted");
	for(i = 0; i < size_; i++)		// Print out the unsorted list
		printf("\n\t %16.7f ", digits[i]);

	printf("\n   Sum is %.8f\n", sumFloats(digits, size_));

	printf("\nSorted");			// Print out the Sorted list
	for(i = 0; i < size_; i++)
		printf("\n\t %16.7f ", digits[i]);
	
	

	// Sin	
	printf("\nSin(.345): %.7f\n", Sine(.345));
//	fprintf(openFile, "\nSin(.345): %.7f\n", Sine(.345));

	printf("\nSin(45): %.7f\n", Sine(45));
//	fprintf(openFile, "\nSin(45): %.7f\n", Sine(45));

	printf("\nSin(36): %.7f\n", Sine(36));
//	fprintf(openFile, "\nSin(36): %.7f\n", Sine(36));
	fclose(openFile);

	return 0;
}

void checkForFile(char filename[]){ 	
	FILE *openFile = fopen( filename, "r" );
	if( !openFile ) {
		FILE *openFile = fopen( filename, "w+" );	// Create the file if it doesnt exist
		fclose(openFile);
	} else {
		printf("The file - %s - already exists, Terminating!\n", filename);
		exit(1);
	}
}




