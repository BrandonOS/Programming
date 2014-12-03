#include <stdio.h>
#include <dlfcn.h>
#include <stdlib.h>
#include "../lib/mylib.h"

void getValues(int *, int *);


int main(){
	int x, y, i, vals;
	//File handling
	FILE *outFile = fopen("export.txt", "w+");
	
	//DLL Handling
	void *handle;
	char *err;

	int (*gcd_d)(int, int);
	int (*mul_d)(int, int);
	int (*div_d)(int, int);
	int (*Exp_d)(int, int);

	handle = dlopen("libmylib.so", RTLD_LAZY);
	if (handle == (void *)0){
		fputs(dlerror(), stderr);
		exit(-1);	
	}

	mul_d = dlsym(handle, "Mul");
	err = dlerror();
	if(err != NULL){
		fputs(err, stderr);
		exit(-1);
	}
	gcd_d = dlsym(handle, "gcd");
	err = dlerror();
	if(err != NULL){
		fputs(err, stderr);
		exit(-1);
	}
	div_d = dlsym(handle, "Div");
	err = dlerror();
	if(err != NULL){
		fputs(err, stderr);
		exit(-1);
	}
	Exp_d = dlsym(handle, "Exp");
	err = dlerror();
	if(err != NULL){
		fputs(err, stderr);
		exit(-1);
	}
	system("clear");


	//Begin Code
	printf("Greatest Common Divisor\n"); 
	fprintf(outFile, "Greatest Common Divisor\n");  // print to file as well

	printf("\tHow many values? "); 			// Get no of inputs
	scanf("%d", &vals);

	for(i = 0; i < vals; i++){			// Loop
		printf("\t %d. ", (i+1));
		getValues(&x, &y);
		printf("\t\tGCD (%d, %d) = %d \n", x, y, gcd_d(x, y)); 
		fprintf(outFile, "\t\tGCD (%d, %d) = %d \n", x, y, gcd_d(x, y)); 

	}

	printf("Multiplication\n"); 
	fprintf(outFile, "Multiplication\n"); 

	printf("\tHow many values? "); 
	scanf("%d", &vals);
	for(i = 0; i < vals; i++){
		printf("\t %d. ", (i+1));
		getValues(&x, &y);
		printf("\t\tMul (%d, %d) = %d \n", x, y, mul_d(x, y)); 
		fprintf(outFile, "\t\tMul (%d, %d) = %d \n", x, y, mul_d(x, y)); 
	}

	printf("Division\n"); 
	fprintf(outFile, "Division\n"); 

	printf("\tHow many values? "); 
	scanf("%d", &vals);
	for(i = 0; i < vals; i++){
		printf("\t %d. ", (i+1));
		getValues(&x, &y);
		printf("\t\tDiv (%d, %d) = %d \n", x, y, div_d(x, y)); 
		fprintf(outFile, "\t\tDiv (%d, %d) = %d \n", x, y, div_d(x, y)); 
	}

	printf("Exponentiation\n"); 
	fprintf(outFile, "Exponentiation\n"); 

	printf("\tHow many values? "); 
	scanf("%d", &vals);
	for(i = 0; i < vals; i++){
		printf("\t %d. ", (i+1));
		getValues(&x, &y);
		printf("\t\tExp (%d, %d) = %d \n", x, y, Exp_d(x, y)); 
		fprintf(outFile, "\t\tExp (%d, %d) = %d \n", x, y, Exp_d(x, y));
	}

	/*
	printf("\t %d \n", gcd_d(25, 15)); 
	printf("\t %d \n", gcd_d(27, 81)); 
	printf("\t %d \n", gcd_d(9, 15)); 
	printf("\t %d \n", gcd_d(625, 300)); 
	printf("\t %d \n", gcd_d(625, 0)); 
	printf("\t %d \n", gcd_d(7, 15));

	printf("Mult\n"); 
	printf("\t %d \n", mul_d(77, 13)); 
	printf("\t %d \n", mul_d(5, 25)); 
	printf("\t %d \n", mul_d(17, 1)); 
	printf("\t %d \n", mul_d(256, 0)); 
	
	printf("Exp\n"); 			
	printf("\t %d \n", Exp_d(10, 0)); 
	printf("\t %d \n", Exp_d(3, 5)); 
	printf("\t %d \n", Exp_d(5, 4)); 
	printf("\t %d \n", Exp_d(763, 0)); 

	printf("Div\n"); 			
	printf("\t %d \n", div_d(25, 4)); 
	printf("\t %d \n", div_d(25, 5)); 
	printf("\t %d \n", div_d(0, 32)); 
	printf("\t %d \n", div_d(25, 4)); 
	printf("\t %d \n", div_d(40, 80));
*/
	// Closure is usually good
	dlclose(handle);
	fclose(outFile);
	return 0;
}

void getValues(int *x, int *y){
	printf("Please enter two values: ");
	scanf("%d %d", x, y);
}
