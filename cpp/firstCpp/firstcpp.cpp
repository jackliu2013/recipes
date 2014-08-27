//#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
//using namespace std;

void handle(int s)
{
    printf("receive SIGCHLD signal\n");
}

int main()
{
	//cout<<"!!!Hello World!!!"<<endl;
    signal(SIGCHLD,handle);
    int sta = 0;

    pid_t p1 = fork();
    if (p1 == -1) {
       printf("fork error\n"); 
       exit(-1);
    }
    if (p1 == 0) {
        // this is child process
        printf("in child pid = %d\n", getpid());
        sleep(10);
        return 0;
    }

    waitpid(p1, &sta, 0);

    printf("child process exit status: %d\n", sta);
	return 0;
}
