/*
* A线程在30秒后,退出，B线程继续执行
* 此程序在A线程退出后，因为线程A没有解锁，导致线程B没法执行
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

pthread_t ta,tb;
pthread_mutex_t m;

void *A(void *data)
{
	int i=0;
	while(1)
	{
		pthread_mutex_lock(&m);
		printf("线程---A!\n");
		i++;
		if(i==30)
		{
			pthread_exit("byebye");
		}
		pthread_mutex_unlock(&m);
		sleep(1);
	}
}

void *B(void *data)
{
	while(1)
	{
		pthread_mutex_lock(&m);
		printf("B---线程!\n");
		sleep(1);
		pthread_mutex_unlock(&m);
	}
}

main()
{
	/* 线程互斥锁  */
	pthread_mutex_init(&m,0);

	/* 创建线程		*/
	pthread_create(&ta,0,A,0);
	pthread_create(&tb,0,B,0);

	pthread_join(ta,0);
	pthread_join(tb,0);

	pthread_mutex_destroy(&m);

}
