#include <signal.h>
#include <stdio.h>

/* 声明一个信号处理函数 */
static void sig_int(int);  /* one handler for both signals */

int main(void)
{
    if (signal(SIGINT, sig_int) == SIG_ERR)
        printf("can't catch SIGINT\n");
     sigset_t sigset;
     sigemptyset(&sigset);
     sigaddset(&sigset, SIGABRT);
     sigsuspend(&sigset);

     printf("end sigsuspend\n");
     return 0;
}

static void sig_int(int signo) /* argument is signal number */
{
    printf("sigle handle function\n");
}

