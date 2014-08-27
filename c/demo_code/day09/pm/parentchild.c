#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

/* 僵尸进程回收函数 */
void handle(int s)
{
	int status;
	wait(&status);
	printf("%d\n",WEXITSTATUS(status));
}

main()
{
	/* 绑定指定信号的处理函数 */
	signal(SIGCHLD,handle);

	if(fork())
	{
		//父进程
		while(1)
		{
			printf("父进程!\n");
			sleep(1);
		}
	}
	else
	{
		//子进程
		while(1)
		{
			printf("子进程!%d\n",getpid());
			sleep(10);
			return 99;
		}
	}

}
