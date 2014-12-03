#include <stdio.h>
#include <stdlib.h>
#include "sockets.h"

int serverFD, connectionFD;             //Server vars
int clConnectionFD;                     //Client vars
char myClock[25];              //Holds the time

char *message;                          //Holds the message
char toSend[120];                       //Time + Message
int time_;                              //How long to sleep

// Pipe variables
int totalTime = 0;                      //Time elapsed

int main(){;
    if (fork() == 0)
    {
        client();                       //Will call Life System & Navigation  
    }
    else{
        start_server();                 //Keep the server running
    }
    return 0;
}

void client(){
        char toRec[120];
	struct sockaddr_in clientAddr;
        int status = 0;                 //Temporary Loop control

	clConnectionFD = socket(AF_INET,  SOCK_STREAM,  0 );

	memset(&clientAddr, 0, sizeof(clientAddr));
	clientAddr.sin_family =  AF_INET;
	clientAddr.sin_port =  htons( SERVER_PORT );
	clientAddr.sin_addr.s_addr =  inet_addr( "127.0.0.1" );  // use server addr, local host

	connect( clConnectionFD,  (struct sockaddr *)&clientAddr,  sizeof(clientAddr));
        while (status){
            totalTime = 0;              //Reset elapsed time
            lifeSupport();
            navigation();
            
            getTime();
            sprintf(toSend, "[ %s ] \tSleep \t\t[ %d seconds ]\n", myClock, 30 - totalTime);		//Attach clock to message
            write( clConnectionFD, toSend, strlen(toSend) + 1 );
            status ++;
            
            sleep(30 - totalTime);          
        }
        
        message = "Stop";
	write( clConnectionFD,  message,  strlen(message)+1 );
        sleep(1);
        
        
	read(clConnectionFD,  toRec,  MAX_LINE );
	printf("Response: %s\n",toRec);
                
}

void start_server() { 
	struct sockaddr_in servaddr;
	int again = 1;
	char buffer[129];

	serverFD = socket( AF_INET, SOCK_STREAM, 0 );
	memset( &servaddr, 0, sizeof(servaddr) ); 

	servaddr.sin_family = AF_INET;  
	servaddr.sin_addr.s_addr = htonl( INADDR_ANY ); 
	servaddr.sin_port = htons( SERVER_PORT ); 

	bind( serverFD,  (struct sockaddr*)&servaddr,   sizeof(servaddr) );
	listen( serverFD,  3 );

	while( again ) {                        //Accept client if waiting 
		connectionFD = accept( serverFD,  (struct sockaddr *)NULL,  NULL);
		if( connectionFD  >=  0 ) {     //Valid connection > 0
                    while(again){
                    read( connectionFD, buffer, MAX_LINE); 
                    again = strcmp(buffer, "Stop");
                            
                    if (again == 0) ;            //Process but do not print "Stop"
                    else
                        printf("%s \n", buffer);
                    }
                    message = "Stopping server"; //Closure
                    write( connectionFD, message, strlen(message) + 1 );
                    close(connectionFD);
		}
	}
}


void lifeSupport(){       		
        getTime();							//Get the clock time
        message = "Beginning life support systems \t";
        sprintf(toSend, "[ %s ] %s ", myClock, message);		//Attach clock to message
        write( clConnectionFD, toSend, strlen(toSend) + 1 );	//Send message to pipe
        sleep(1);							
        totalTime ++;
        
        getTime();
        time_ = generate(5);            
        message = "Adjusting breathing gas levels"; 
        sprintf(toSend, "[ %s ] %s  \t[ %d Second(s) ]", myClock, message, time_);
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        countdown(time_);  
        totalTime += time_;

        getTime();
        time_ = generate(3);
        message = "Adjusting environment";   
        sprintf(toSend, "[ %s ] %s  \t\t[ %d Second(s) ]", myClock, message, time_);
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        countdown(time_); 
        totalTime += time_;
        
        getTime();
        message = "Done. Life support adjusted. \t[ 1 Second(s) ]";   
        sprintf(toSend, "[ %s ] %s ", myClock, message);
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        getTime();
        message = "\t\tExecution time";
        sprintf(toSend, "%s [ %d Second(s) ]\n", message, (totalTime - 1));
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
	sleep(1);
	totalTime ++;
}

void navigation(){  
        getTime();	
        message = "Beginning navigation systems";
        sprintf(toSend, "[ %s ] %s \t[ 1 Second(s) ]", myClock, message);		
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        getTime();
        time_ = generate(6);
        message = "Adjusting navigation systems";  
        sprintf(toSend, "[ %s ] %s  \t[ %d Second(s) ]", myClock, message, time_);
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        countdown(time_); 
        totalTime += time_;

        getTime();
        message = "Done. Navigation systems adjusted \t[ 1 Second(s) ]";          
        sprintf(toSend, "[ %s ] %s ", myClock, message);
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime ++;
        
        message = "\t\tExecution time";
        sprintf(toSend, "%s  [ %d Second(s) ]", message, (totalTime - 2));
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        sleep(1);
        totalTime += 2;
        
        getTime();        
        message = "\tTotal time";
        sprintf(toSend, "[ %s ] %s \t[ %d Second(s) ]",  myClock, message, totalTime);		
        write( clConnectionFD, toSend, strlen(toSend) + 1 );
        sleep(1);
}

void countdown(int x){
	int i;
	//printf("\t\t");
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

void getTime(){
    time_t now;
    struct tm *temp;
    now = time( NULL );
    temp = localtime( &now );
    
    //Create the clock using struct
    sprintf(myClock, "%.2d:%.2d:%.2d", temp->tm_hour, temp->tm_min, temp->tm_sec );
 }
