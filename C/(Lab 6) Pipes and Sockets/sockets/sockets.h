#ifndef __engine
#define __engine

#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <time.h>
#include <unistd.h>
#include <wait.h>

#define MAX_LINE 128
#define SERVER_PORT 6379
extern void client();
extern void start_server();
extern void getTime();
extern void lifeSupport();
extern void navigation();
extern int generate(int);
extern void countdown(int);

#endif

