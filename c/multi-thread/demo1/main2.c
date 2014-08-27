#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>


pthread_t t1, t2;
int sum = 0;
int multi = 0;
int arr[2] = {0};

// 互斥量
pthread_mutex_t m;

// 条件量
pthread_cond_t c;

// 相加的线程处理
void *sumply() {
	while(1) {
		if ( (0 == arr[0]) && (0 == arr[1]) ) {
			return;
		}
		pthread_mutex_lock(&m); // 
        pthread_cond_wait(&c,&m);
		sum = arr[0] + arr[1];
		printf("sum is %d\n", sum);
		pthread_mutex_unlock(&m);   //
	}

	
}

// 相乘的线程处理
void *multiply() {
	while(1) {
		if ( (0 == arr[0]) && (0 == arr[1]) ) {
			return;
		}
		pthread_mutex_lock(&m); // 
        pthread_cond_wait(&c,&m);
		multi = arr[0] * arr[1];
		printf("multi is %d\n", multi);
		pthread_mutex_unlock(&m);   //

	}
}


int main() {

    // initialize mutex variable
	pthread_mutex_init(&m,0);

    // initialize condation variable
    pthread_cond_init(&c,0);

    /*  */
    pthread_create(&t1,0, sumply,0);
    pthread_create(&t2,0, multiply,0);
	
	while(1)
    {
        //
        sleep(1);

        // 
        pthread_mutex_lock(&m); // ºóÀ´Ìí¼Ó
		printf("please input two integer\n");
		scanf("%d %d", &arr[0], &arr[1]);
        pthread_cond_broadcast(&c);
        pthread_mutex_unlock(&m);   // ºóÀ´Ìí¼Ó
		if ( (0 == arr[0]) && (0 == arr[1]) ) {
			break;
		}
    }

	pthread_join(t1,(void **)0);
    pthread_join(t2,(void **)0);
	printf("all is over\n");

	pthread_cond_destroy(&c);

    // ÊÍ·Å»¥³âÁ¿
    pthread_mutex_destroy(&m);

}
