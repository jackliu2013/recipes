#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void) 
{
    pid_t pid;

    if ( (pid=fork()) < 0 ) {
        printf("fork error\n");
    }
    else if (pid == 0) { /* first child */
        
        if ( (pid = fork()) < 0 ) {
            printf("fork error\n");
        }
        else if ( pid > 0 )  /* first child fork success */
            /* first child exit */
            exit(0);     /* parent from second fork == first child */

        /*
            we're the second child; our parent becomes init as soon as
            our real parent calls return in the statement above.
            here's where we'd continue executing, knowing that when 
            we're done, init will reap out status.
        */
        sleep(5);
        printf("second child, parent pid = %d\n", getppid());
        exit(0);
    }
 
    /* wait for first child */
    if ( waitpid(pid, NULL, 0) != pid ) {
       printf("waitpid error\n"); 
    }

    /*
        we are the parent (the original proecess); 
        we continue executing, knowing that we're not the parent 
        of the second child.
    */

    exit(0);
}
