#include <signal.h>
#include <stdio.h>

/* 声明一个信号处理函数 */
static void sig_user(int);  /* one handler for both signals */

int main(void)
{
    if (signal(SIGUSR1, sig_user) == SIG_ERR)
        printf("can't catch SIGUSR1\n");
    if (signal(SIGUSR2, sig_user) == SIG_ERR)
        printf("can't catch SIGUSR2\n");
    
    while(1) {
        pause();
    }
}

static void sig_user(int signo) /* argument is signal number */
{
    if (signo == SIGUSR1) {
        sleep(20);
        printf("received SIGUSR1\n");
    }
    else if (signo == SIGUSR2) {
        sleep(20);
        printf("received SIGUSR2\n");
    }
    else
        printf("received signal %d\n", signo);
    
    printf("sigle handle function end\n");
    return;
}

/*
 如果在信号处理函数执行期间，程序收到其他信号，有可能会影响
 到对信号SIGUSR1 SIGUSR2的处理
*/
