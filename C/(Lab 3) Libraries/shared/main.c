#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "myLib.h"


int main(){
	float radius, surface, volume;
	char outFile[24] = "";

	FILE *openFile; 
	openFile = fopen( "export.txt", "w+" );

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

	fclose(openFile);

	openFile = fopen( "export.txt", "a" );

	// Array
	float digits[8];
	int i, size_  = 8;	
	for(i = 0; i < 8; i++){
		printf("Enter floating point (%d): ", (i + 1));
		scanf("%f", &digits[i]);
	}
		
	printf("\nUnsorted");
	fprintf(openFile, "\nUnsorted");
	for(i = 0; i < size_; i++)	{				// Print out the unsorted list (fprintf) 
		printf("\n\t %16.7f ", digits[i]);
		fprintf(openFile, "\n\t %16.7f ", digits[i]);
	}
	
	double sum = sumFloats(digits, size_);
	printf("\nThe sum is: \t%.8f", sum);
	fprintf(openFile, "\n\nThe sum is: \t%.8f", sum);
	
	printf("\nSorted");
	fprintf(openFile, "\nSorted");
	for(i = 0; i < size_; i++)	{				// Print out the unsorted list (fprintf) 
		printf("\n\t %16.7f ", digits[i]);
		fprintf(openFile, "\n\t %16.7f ", digits[i]);
	}


	// Sin	
	printf("\nSin(.345): %.9f\n", Sine(.345));
	fprintf(openFile, "\n\nSin(.345): %.8f\n", Sine(.345));

	printf("\nSin(45): %.9f\n", Sine(45));
	fprintf(openFile, "\nSin(45): %.8f\n", Sine(45));

	printf("\nSin(36): %.9f\n", Sine(36));
	fprintf(openFile, "\nSin(36): %.8f\n", Sine(36));

	fclose(openFile);


	return 0;
}
