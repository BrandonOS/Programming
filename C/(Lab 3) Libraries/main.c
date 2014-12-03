#include <stdio.h>
#include <math.h>

void sphere( float, float *, float *);
float volCylinder( float, float);
double sumFloats( float [], int);
double Sine(float);
int fact(int);

int main(){
	float radius = 1, surface, volume;
	
	printf("Please enter the radius: ");
	//scanf("%f", &radius);
	
	sphere(radius, &surface, &volume);
	
	printf("The surface area of a sphere is: %.2f\nThe volume is %.2f\n", surface, volume);
	
	float height = 2;
	printf("Please enter the height: ");
	//scanf("%f", &height);

	printf("The volume of a cylinder is %.2f\n", volCylinder(radius, height));

	float digits[] = { 0.3476789, 100400.8, 0.0000099, 1.343567, 78.34567, 1678.567, 997999.6, 0.0000009};
	sumFloats(digits, 8);
	printf("Factorial: %d\n", fact(1));

	printf("\nSin(.345): %.7f\n", Sine(.345));
	printf("\nSin(45): %.7f\n", Sine(45));
	printf("\nSin(36): %.7f\n", Sine(36));

	return 0;
}

void sphere( float radius, float *surface, float *volume){
	*surface  = M_PI * 4 * radius * radius;
	*volume  = M_PI * ( 4 / 3 ) * radius * radius * radius;
}

float volCylinder( float radius, float height){
	return M_PI * radius * radius * height;
}

double sumFloats( float a[], int size_ ){
	int i, j, pos;
	float smallest, temp;
	double sum = 0.0;
	printf("\nUnsorted");
	for(i = 0; i < size_; i++)		// Print out the unsorted list
		printf("\n\t %16.7f ", a[i]);
		

	for(i = 0; i < size_ - 1; i++){		// Sorting algorithm
		smallest = a[i];	
		for (j = i; j < size_; j++){	
			if (smallest > a[j]){
				smallest = a[j];
				pos = j;							
			}
		}			
		temp = a[i];
		a[i] = smallest;
		a[pos] = temp;	
	}

	printf("\nSorted");			// Print out the Sorted list (while calculating total)
	for(i = 0; i < size_; i++){
		printf("\n\t %16.7f ", a[i]);
		sum += a[i];	
	}
	printf("\n   Sum is %.8f\n", sum);
	return sum;
}

double Sine(float x){
	(x > 5) ? x = M_PI * x / 180 : printf("\n");		// Calculate radian equivalent


	double ans = 0, temp, difference = 1, total;
	int j, n = 2;
	
	for(j = 1; difference > .00000001; j++, n++){		//Taylor Series
		temp = ans;					//Store previous value	
		ans = pow(-1, n) * pow(x, j) / fact(j);		//Calculate next value
		total += ans;					//Add next value to total
		difference = temp + ans;			//  Check how much difference has changed
//		printf("\t\t(%.8f + %.8f) = %.8f \t (Total = %.8f)\n", temp, ans, difference, total);
		
		j++;		
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


