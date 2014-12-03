#include <stdio.h>
#include <time.h>
#define OR ||

int main(){
char employeeName[21];

int employeeNo, lineNo = 1;

double yearToDate, gross = 0, totalGross = 0, ficaLimit = 69782;
double taxRate, ficaRate = 0.0678, totalFica = 0.00;
char proceed = 'y';
int i;
for (i = 0; i < 90; i++) // Separate the header
	printf("-");

time_t now;
time(&now);
printf("\n\t\t \t\t ACME Inc \t\t\t%.24s\n", ctime(&now));

for (i = 0; i < 90; i++) // Bottom of the header
	printf("-");
	
printf("\n");

while (proceed == 'y' OR proceed == 'Y'){
	printf("Please enter the employees name: ");
	scanf("%s", employeeName);

	printf("Please enter the employee number: ");
	scanf("%d", &employeeNo);

	printf("Please enter earnings to date: ");
	scanf("%lf", &yearToDate);
	
	printf("Please enter the gross: ");
	scanf("%lf", &gross);
	if (yearToDate < ficaLimit)
	{
		
		taxRate = (ficaLimit - yearToDate) * ficaRate;
		
		if(yearToDate + gross <= ficaLimit){
			taxRate = gross * ficaRate;
		}
		else{	
			taxRate = (ficaLimit - yearToDate) * ficaRate;	
		}	
	}

	printf("Line\t Employee Name\t\t     ID\t\t YTD          \t Gross         \t FICA Tax\n");
	
	printf("%-4d\t %-12s \t\t %6d\t\t $%-8.2f\t $%-8.2f\t $%-8.2f\n" ,lineNo, employeeName, employeeNo, (double) yearToDate,(double) gross, taxRate);

	lineNo++;
	
	printf("\nDo you want to continue? (Y or N): ");
	scanf("%s", &proceed);

	totalGross += gross;
	totalFica += taxRate;

	gross = 0, taxRate = 0;
	
	}

	for(i = 0; i < 90; i++) // Print the top line
	printf("-");

	printf("\n\t\t \t\t \t\t Total: \t $%.2f\t $%.2f\n", totalGross, totalFica);

	for(i = 0; i < 90; i++) //Print the bottom line
	printf("-");

	printf("\n");

} 
