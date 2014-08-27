#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

pthread_mutex_t m; //1

int a,b;

void display()
{
		pthread_mutex_lock(&m);	//m=0,直接返回,并且把m=1 ，否则阻塞
		a++;
		b++;
		if(a!=b)
		{
			printf("%d!=%d\n",a,b);
			a=b=0;
		}
		pthread_mutex_unlock(&m);//把m变成0，直接返回	
		
}
void *r1(void *data)
{
	while(1)
	{
		display();
	}

}

void *r2(void *data)
{
	while(1)
	{
		display();
	}

}

main()
{
	pthread_mutex_init(&m,0);//2
	a=b=0;
			
	pthread_t t1,t2;

	pthread_create(&t1,0,r1,0);
	pthread_create(&t2,0,r2,0);
	

	pthread_join(t1,(void **)0);
	pthread_join(t2,(void **)0);
	pthread_mutex_destroy(&m);
}
