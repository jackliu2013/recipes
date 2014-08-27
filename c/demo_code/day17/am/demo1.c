#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>


main()
{
	if(fork())
	{
		//父进程
		sigset_t sigs;
		sigemptyset(&sigs);
		/* 把34信号放进信号集合		*/
		sigaddset(&sigs,34);
		int s;
	
		while(1)
		{
			sigwait(&sigs,&s);
			printf("received signal 34!\n");
		}

	}
	else
	{
		//子进程
		while(1)
		{
			sleep(1);
			kill(getppid(),34);
			printf("send signal 34!\n");
		}

	}


}
