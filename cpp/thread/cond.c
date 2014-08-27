/*
    线程1，线程2 线程3 把sum的累加到100，当sum=100时， 线程4把sum重新清0
*/
#include <stdio.h>
#include <pthread.h>
#include "stdlib.h"
#include "unistd.h"

/* 定义互斥锁 和 条件变量 */
pthread_mutex_t mutex;
pthread_cond_t cond;

/* 全局变量 */
int sum = 0;

/*
    线程1 2 3 思路: 
       1) 先拿到互斥锁
       2) 判断sum >= 100 如果为真, pthread_cond_signal 发送条件量
       3) 释放互斥锁
    
    线程4 思路:
       1) 先拿到互斥锁
       2) 判断sum < 100 如果为真, pthread_cond_wait 阻塞等待条件量为真和互斥锁资源，如果得不到条件量则释放其占用的互斥锁
                        如果为假, sum = 0 
       3) 释放互斥锁
*/

/* 线程1执行代码 */
void *thread1(void *arg)
{
    while(1)
    {
        pthread_mutex_lock(&mutex);
        if(sum >= 100)
        {
            pthread_cond_signal(&cond);
            pthread_mutex_unlock(&mutex);
            sleep(1);
        }
        sum++;
        printf("thread1 sum is %d\n", sum);
        pthread_mutex_unlock(&mutex);
        
    }
}

/* 线程2执行代码 */
void *thread2(void *arg)
{
    while(1)
    {
        // pthread_mutex_lock(&mutex);
        // if(sum >= 100)
        // {
        //     pthread_cond_signal(&cond);
        //     pthread_mutex_unlock(&mutex);
        //     sleep(1);
        // }
        // else {
        //     sum++;
        //     printf("thread2 sum is %d\n", sum);
        //     pthread_mutex_unlock(&mutex);
        // }
        pthread_mutex_lock(&mutex);
        if(sum >= 100)
        {
            pthread_cond_signal(&cond);
            pthread_mutex_unlock(&mutex);
            sleep(1);
        }
        sum++;
        printf("thread2 sum is %d\n", sum);
        pthread_mutex_unlock(&mutex);
    }
}

void *thread3(void *arg)
{
    while(1) 
    {
        // pthread_mutex_lock(&mutex);
        // if(sum >= 100)
        // {
        //     pthread_cond_signal(&cond);
        //     pthread_mutex_unlock(&mutex);
        //     sleep(1);
        // }
        // else {
        //     sum++;
        //     printf("thread3 sum is %d\n", sum);
        //     pthread_mutex_unlock(&mutex);
        // }
        pthread_mutex_lock(&mutex);
        if(sum >= 100)
        {
            pthread_cond_signal(&cond);
            pthread_mutex_unlock(&mutex);
            sleep(1);
        }
        sum++;
        printf("thread3 sum is %d\n", sum);
        pthread_mutex_unlock(&mutex);
    }
}

void *thread4(void *arg)
{
    while(1) 
    {
        pthread_mutex_lock(&mutex);
        printf("thread4 sum is %d\n", sum);
        while(sum < 100) 
        {
            pthread_cond_wait(&cond, &mutex);
        }
        printf("thread4 sum is over 100!\n");
        sum = 0;
        pthread_mutex_unlock(&mutex);
    }

}


int main()
{
    pthread_t thid1,thid2, thid3, thid4;
    printf("condition variable study!\n");
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&cond, NULL);

    pthread_create(&thid1, NULL, thread1, NULL);
    pthread_create(&thid2, NULL, thread2, NULL);
    pthread_create(&thid3, NULL, thread3, NULL);
    pthread_create(&thid4, NULL, thread4, NULL);
    
    pthread_join(thid1, NULL);
    pthread_join(thid2, NULL);
    pthread_join(thid3, NULL);
    pthread_join(thid4, NULL);

}



