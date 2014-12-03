#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double calFica(int, double, int, double);
int calGross(int, double);
double calNet(double, double);
void header(char[]);
void newPage(int* , int, char[]);
void footer(int, double, double, double, char[]);
void closingPage(int*, int, double, double, double, char[]);
void checkForFile(char[], int);

int main(){
	char inputFile[24] = "";
	char outFile[24] = "";
	
	printf("Please enter the name of input data file  (max 20 characters): ");
	scanf("%s", inputFile);
	strcat (inputFile,".txt");
	checkForFile(inputFile, 0);

	printf("Please enter name of report file to be generated (max 20 characters): ");
	scanf("%s", outFile);
	strcat (outFile,".txt");
	checkForFile(outFile, 1);
	


	FILE *ficaTxt = fopen("fica.txt", "r");
	FILE *inFile = fopen(inputFile, "r");
	FILE *reportFile = fopen(outFile, "a");
	fclose(reportFile);
	


	int PK = 0;
	int LK = 0;
	const int Max_Lines = 5;
	int noOfRecords = 0;

	double ficaRate;
	int ficaLimit;
	char st1[9], st2[8];


	int empNo;
	char givenName[15], surName[15], dept[6];
	double ytd, payRate, hours;

	double totalGross = 0, totalFica = 0, totalNet = 0;
	
	while ( fscanf(ficaTxt, "%s %d %s %lf", st1, &ficaLimit, st2, &ficaRate) != EOF ) { };		// Get the current FICA values
	fclose(ficaTxt);

	if( PK == 0 ) header(outFile);

	//Start to Read the file
	double fica, gross, net;
	double tFica = 0, tGross = 0, tNet = 0;	
	if(PK == 0) newPage(&PK, LK, outFile);

	while ( fscanf(inFile, "%d %s %s %s %lf %lf %lf", &empNo, givenName, surName, dept, &ytd, &payRate, &hours) != EOF ) 
	{	
		FILE *reportFile = fopen(outFile, "a");
		
						//
		gross = calGross(hours, payRate);	
		fica = calFica(ytd, gross, ficaLimit, ficaRate);
		net = calNet(gross, fica);


		fprintf(reportFile, "%-5d \t%-12s\t %-12s\t %5s\t %9.2f\t %8.2f\t  %6.2f\t %8.2f\n", empNo, givenName, surName, dept, ytd, gross, fica, net);
		printf("%-5d \t%-12s\t %-12s\t %5s\t %9.2f\t %8.2f\t  %6.2f\t %8.2f\n", empNo, givenName, surName, dept, ytd, gross, fica, net);
	noOfRecords++;

	totalGross += gross;
	totalFica += fica;
	totalNet += net;
	LK++;
	fclose(reportFile);

	// Check the Line counter to see if we need a new header
	if (LK == Max_Lines){		
		footer(PK, totalGross, totalFica, totalNet, outFile);
		newPage(&PK, LK, outFile);
		header(outFile);
		
		LK = 0;
		
		tGross += totalGross;
		totalGross = 0;

		tFica += totalFica;
		totalFica = 0;

		tNet += totalNet;
		totalNet = 0;
			
		}
	}
	
	// print the rest of the report (if theres any unaccounted items)
	if(LK > 0 && LK < Max_Lines){
			
		footer(PK, totalGross, totalFica, totalNet, outFile);

		int i;	
		FILE *openFile = fopen(outFile, "a");	
		for (i = LK; i < Max_Lines; i++){
			printf("\n");
			fprintf(openFile, "\n");
			LK++;			
		}	
		PK++;
		fclose(openFile);

	}
	
	closingPage(&PK, noOfRecords, tGross, tFica, tNet, outFile);
return 0;	
}

void closingPage(int *PK, int noOfRec, double totalGross, double totalFica, double totalNet, char fileName[24]){	
	FILE *openFile = fopen( fileName, "a" );

	int i, pageNo = *PK;
	for(i = 0; i <= 70; i++ ) printf ("_");
	printf("\n\t\t\tACME Sports Inc.");
	fprintf(openFile, "\n\t\t\tACME Sports Inc.");

	printf("\n\t\t\t Report Summary\n");
	fprintf(openFile, "\n\t\t\t Report Summary\n");

	printf("%25s:\t %d\n",	 "Records processed", noOfRec);
	fprintf(openFile, "%25s:\t %d\n",	 "Records processed", noOfRec);

	printf("%25s:\t %.2f\n", "Total Gross", totalGross);
	fprintf(openFile, "%25s:\t %.2f\n", "Total Gross", totalGross);

	printf("%25s:\t %.2f\n", "Total FICA", totalFica);
	fprintf(openFile, "%25s:\t %.2f\n", "Total FICA", totalFica);

	printf("%25s:\t %.2f\n", "Total Net", totalNet);
	fprintf(openFile, "%25s:\t %.2f\n", "Total Net", totalNet);

	printf("\t\t\t\t\t\t\t\tPage %d \n", pageNo);
	fprintf(openFile, "\t\t\t\t\t\t\t\tPage %d \n", pageNo);
	pageNo++;
	*PK = pageNo;
	for(i = 0; i <= 70; i++ ) printf ("_");		
	printf("\n");	

	fclose(openFile);
}

void checkForFile(char filename[], int flag){ 
	
	FILE *openFile = fopen( filename, "r" );
	if( flag == 0 && !openFile ) {
		printf(" ( %s ) file does not exist, terminating!\n", filename );
		exit( 1 );
	}
	else if( flag == 1 ) {	
		if (openFile){				// if it already exists, dont create a new one
			printf(" ( %s ) file already exists, please try again. Terminating!\n", filename);
			fclose(openFile);
			exit( 1 ); 	
		} 	
	}
}


