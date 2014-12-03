/* 
 * File:   main.c
 * Author: bos002
 *
 * Created on March 29, 2007, 4:53 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include "engine.h"

//Global Vars
int ret, myPipes[2]; 
char *message;

int time_;
char myClock[25];

// Pipe variables
int totalTime = 0;              				// Total time
char toSend[120];              					// Final message

/*
 * 
 */
int main() { 
	int temp = 0;						//loop counter (delete when finished)
char buffer[MAX_LINE + 1];					//Parent buffer
	ret = pipe( myPipes );  
    
	int again = 1, repeat = 1;
    
	if( ret == 0 ){
        	if(fork() == 0){
		    // Child
		    while (repeat){
			totalTime = 0;           		//Reset the total time
			getTime();

			lifeSupport();            
			navigation(); 
			
			getTime();				//Attach clock to message
			sprintf(toSend, "[ %s ] \tSleep \t\t[ %d seconds ]\n", myClock, 30 - totalTime);		
			write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
			
		sleep(30 - totalTime); 				// Subtract totalTime from 30		
		    }
                        
       		}  else
		{
		    // Parent           
	    while(again){					//keep listening for a message
		        read( myPipes[PipeStdIn], buffer, MAX_LINE); 
		        again = strcmp(buffer, "Stop");
		                        
		        
	        if (again == 0) ;  				// Process but do not print "Stop"
		        else
		            printf("%s \n", buffer);
		    }
		    printf("Back in parent\n");
		}
	    }
    
	return (EXIT_SUCCESS);
}


void lifeSupport(){       		
        getTime();						//Get the clock time
        message = "Beginning life support systems \t";
        sprintf(toSend, "[ %s ] %s ", myClock, message);		//Attach clock to message
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );	//Send message to pipe
        sleep(1);							
        totalTime ++;
        
        getTime();
        time_ = generate(5);            
        message = "Adjusting breathing gas levels"; 
        sprintf(toSend, "[ %s ] %s  \t[ %d Second(s) ]", myClock, message, time_);
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        countdown(time_);  
        totalTime += time_;

        getTime();
        time_ = generate(3);
        message = "Adjusting environment";   
        sprintf(toSend, "[ %s ] %s  \t\t[ %d Second(s) ]", myClock, message, time_);
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        countdown(time_); 
        totalTime += time_;
        
        getTime();
        message = "Done. Life support adjusted. \t[ 1 Second(s) ]";   
        sprintf(toSend, "[ %s ] %s ", myClock, message);
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        getTime();
        message = "\t\tExecution time";
        sprintf(toSend, "%s [ %d Second(s) ]\n", message, (totalTime - 1));
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
	sleep(1);
	totalTime ++;
}

void navigation(){  
        getTime();	
        message = "Beginning navigation systems";
        sprintf(toSend, "[ %s ] %s \t[ 1 Second(s) ]", myClock, message);		
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        getTime();
        time_ = generate(6);
        message = "Adjusting navigation systems";  
        sprintf(toSend, "[ %s ] %s  \t[ %d Second(s) ]", myClock, message, time_);
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        countdown(time_); 
        totalTime += time_;

        getTime();
        message = "Done. Navigation systems adjusted \t[ 1 Second(s) ]";          
        sprintf(toSend, "[ %s ] %s ", myClock, message);
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        message = "\t\tExecution time";
        sprintf(toSend, "%s  [ %d Second(s) ]", message, (totalTime - 2));
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime += 2;
        
        getTime();        
        message = "\tTotal time";
        sprintf(toSend, "[ %s ] %s \t[ %d Second(s) ]",  myClock, message, totalTime);		
        write( myPipes[PipeStdOut], toSend, strlen(toSend) + 1 );
        sleep(1);
}
void countdown(int x){
	int i;
	for(i = x; i > 0; i--){
		sleep(1);		
	}
}

int generate(int x){
	int i;	
	srand (time(NULL));		// Seed the time
	i = (rand() % x) + 1;		// Generate a number > 1
	
	return i;
}

void getTime(){				//get the current time & save it
    time_t now;
    struct tm *temp;
    now = time( NULL );
    temp = localtime( &now );
    
    sprintf(myClock, "%.2d:%.2d:%.2d", temp->tm_hour, temp->tm_min, temp->tm_sec );
 }

