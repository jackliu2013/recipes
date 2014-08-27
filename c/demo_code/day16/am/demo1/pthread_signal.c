/*
* 
*
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <signal.h>

void handler(int s)
{
	printf("有信号!\n");
}
pthread_t ta,tb;

void *A(void *data)
{
	signal(34,handler);
	while(1)
	{
		printf("线程---A!\n");
		sleep(1);
		
		/* 向自己线程所在的进程发送信号 */
		//raise(34);
		//kill(getpid(),34);

		/* 每隔一秒向B线程发送信号	*/
		pthread_kill(tb,34); /*对线程tb所在的进程发送信号*/
	}
}

void *B(void *data)
{
	//signal(34,handler);
	while(1)
	{
		printf("B---线程!\n");
		sleep(3);
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
