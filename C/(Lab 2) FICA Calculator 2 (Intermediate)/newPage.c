#include <stdio.h>
void header(char[]);

void newPage(int *PK, int LK, char fileName[24]){
	int counter = *PK;

	counter++;
	*PK = counter;

}
void header(char outFile[24]){
	FILE *reportFile = fopen(outFile, "a");	
	int i;
		printf("\n\t\t\t\t\t\tACME Sports Inc.\n");
		fprintf(reportFile, "\n\t\t\t\t\t\tACME Sports Inc.\n");

		printf("\t\t\t\t\tWe are the best, you use the best!\n");
		fprintf(reportFile, "\t\t\t\t\tWe are the best, you use the best!\n");


		for(i = 0; i < 105; i++ ) { printf ("-");  fprintf(reportFile, "-"); }
		printf("\n");
		fprintf(reportFile, "\n");
		
		printf("Emp # \tName \t\t\t\t  Dept.\t   New YTD\t   Gross\t    FICA\t      Net\n");
		fprintf(reportFile, "Emp # \tName \t\t\t\t  Dept.\t   New YTD\t   Gross\t    FICA\t      Net\n"); 
		fclose(reportFile);

}
void footer(int pageNo, double tGross, double tFica, double tNet, char outFile[24]){
	FILE *reportFile = fopen(outFile, "a");
	int i;		
		for(i = 0; i < 105; i++ ) { printf ("-");  fprintf(reportFile, "-"); }
		printf("\nPage totals: \t\t\t\t\t\t\t %8.2f \t%8.2f\t %8.2f\n", tGross, tFica, tNet);
		fprintf(reportFile, "\nPage totals: \t\t\t\t\t\t\t %8.2f \t%8.2f\t %8.2f\n", tGross, tFica, tNet);

		printf("\t\t\t\t\t\t\t\t\t\t\t\t   Page %d\n", pageNo);
		fprintf(reportFile, "\t\t\t\t\t\t\t\t\t\t\t\t   Page %d\n", pageNo);
		for(i = 0; i < 105; i++ ) { printf ("-");  fprintf(reportFile, "-");}
		
		printf("\n");
		fprintf(reportFile, "\n");
		fclose(reportFile);
 	}


