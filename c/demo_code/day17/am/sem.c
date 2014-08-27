/*
*	信号量(信号灯)来控制线程
* 	信号量（信号灯)对线程的控制调度是不均匀的
* 	抢占权高的线程运行的时间长
* 	抢占权低的线程运行的时间短
*/
#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

pthread_t t1,t2;

/* 信号量的定义		*/
sem_t sem;

/* 线程t1的处理函数		*/
void *r1(void *d)
{
	while(1)	//等待信号量
	{
		sem_wait(&sem);
		printf("thread1----!\n");
	}
}

/* 线程t2的处理函数		*/
void *r2(void *d)
{
	while(1)	//等待信号量
	{
		sem_wait(&sem);
		printf("thread2----!\n");
	}
}

main()
{
	/* 初始化信号量，0表示在线程使用，10表示信号量的初始值	*/
	sem_init(&sem,0,10);

	/* 创建2个线程	*/
	pthread_create(&t1,0,r1,0);
	pthread_create(&t2,0,r2,0);

	while(1)
	{
		/* 发送信号量		*/
		sleep(2);
		sem_post(&sem);

	}
	sem_destroy(&sem);
}
