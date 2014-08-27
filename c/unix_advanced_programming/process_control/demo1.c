#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

/*
#include "ourhdr.h"
*/

int glob = 6 ;  /* external variable in initialized data */
char buf[] = "a write to stdout\n" ;

int main(void)
{
    int     var ;
    pid_t   pid;
    int *status = NULL;

    var = 88 ;

    if ( write(1, buf, sizeof(buf)-1) != sizeof(buf) - 1 ) {
        printf("write error\n") ;
    }

    printf("before fork\n") ;       /* we don't flush stdout */

    if ( ( pid = fork() ) < 0 ) {
        printf("fork error\n") ;
    }
    else if ( pid == 0 ) {  /* child process */
        glob ++;
        var ++;
    }
    else {
        sleep(12) ;         /* parent process */
    }

    waitpid(pid,status,WNOHANG);

    printf("pid = %d, glob = %d, var = %d\n", getpid(), glob, var) ;
    
    return 1;

}
