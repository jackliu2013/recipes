/*
* A线程在30秒后终止B线程
*
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

pthread_t ta,tb;
int b=0;
void *A(void *data)
{
	int i=0;
	while(1)
	{
		printf("线程---A!\n");
		sleep(1);
		i++;
		if(i==30)
		{
			//pthread_cancel(tb);
			b=1;
		}

	}
}

void *B(void *data)
{
	while(1)
	{
		printf("B---线程!\n");
		sleep(1);
		if(b==1)
		{
			pthread_exit(0);
		}
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
