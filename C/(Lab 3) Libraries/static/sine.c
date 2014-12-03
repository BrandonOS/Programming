#include <stdio.h>
#include <math.h>
int fact(int);
const double EPSILON = 0.00000001;

double Sine(float x){
	(x > 5) ? x = M_PI * x / 180 : printf(" \b");		// Calculate radian equivalent (if greater than 


	double total = 0, prev = x;
	int j, n = 2;
	
	for(j = 1; fabs(prev - total) > EPSILON; j+=2, n++){	//Taylor Series
		prev = total;	
		total += pow(-1, n) * pow(x, j) / fact(j);		//Calculate next value			
	}

	

	return total;
}

int fact(int x){
	int i, fact = 1;
	if (x < 0)
		return -1;
	else if (x == 0)
		return 1;

	for (i = 1; i <= x; i++)
		fact *= i;

	return fact;
}

