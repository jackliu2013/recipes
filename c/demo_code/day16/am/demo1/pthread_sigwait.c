/*
* 
*
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>

pthread_t ta,tb;

void *A(void *data)
{

	while(1)
	{
		//printf("线程---A!\n");
		sleep(2);
		
		/* 向自己线程所在的进程发送信号 */
		//raise(34);
		//kill(getpid(),34);

		/* 每隔一秒向B线程发送信号	*/
		pthread_kill(tb,34); /*对线程tb所在的进程发送信号*/
	}
}

void *B(void *data)
{
	/* for sigwait */
	sigset_t sigs;
	sigemptyset(&sigs);
	sigaddset(&sigs,34);
	int s;

	while(1)
	{
		sigwait(&sigs,&s);
		printf("B---线程!\n");
		sleep(1);
	}
}

main()
{
	/* 创建线程		*/
	pthread_create(&ta,0,A,0);
	pthread_create(&tb,0,B,0);

	pthread_join(ta,0);
	pthread_join(tb,0);

}
