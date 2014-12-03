#ifndef __engine
#define __engine

#include <stdio.h>
#include <string.h>	
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>	
#include <stdlib.h> 		
#include <time.h>   
#include <wait.h>

#define FIFO_FILE "/tmp/iofile"
#define PipeStdIn   0       //stdin for Unix is  0, default is keyboard.
#define PipeStdOut  1     //stdout  for Unix is 1, default is crt.


extern void getTime();
extern void writeToMain(char *, int);
extern void lifeSupport();
extern void navigation();
extern int generate(int);
extern void countdown(int x);

const int MAX_LINE = 80;

#endif

