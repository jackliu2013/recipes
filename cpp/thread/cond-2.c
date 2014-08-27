//一个多线程例子：三个线程  0 1 往水池中加水。 线程2放水。  如果水池满 则阻塞进水线程  等待
 
#include <unistd.h>
#include <pthread.h>
#include <stdio.h>
#include <errno.h>
#include<semaphore.h>
 
pthread_mutex_t Poll_Work;       //互斥锁
sem_t Poll_IN;                   //水池容量信号量                  
sem_t Poll_OUT;                  //当前水量信号量
 
void* thread0(void *param)            //0 1线程往水池中加水。
{
    while(1){
        int rv = 0;
        for(int i = 0; i < 5; ++ i)
            while((rv = sem_wait(&Poll_IN)) != 0 && (errno == EINTR))          //水量增加5  循环使得容量信号量减少5
                ;
        pthread_mutex_lock(&Poll_Work);               //加锁  线程互斥
        (*(int*)param) += 5;
        printf("Thread0: %d\n", *(int*)param);
        for(int i = 0; i < 5; ++ i)
            sem_post( &Poll_OUT);                    //增加当前水量信号量
        pthread_mutex_unlock(&Poll_Work);             //解锁。
         
        sleep(1);
    }
    return NULL;
}
 
void* thread1(void *param)
{
    while(1){
        int rv = 0;
        for(int i = 0; i < 4; ++ i)
            while((rv = sem_wait(&Poll_IN)) != 0 && (errno == EINTR) )   
                ;
        pthread_mutex_lock(&Poll_Work);
        (*(int*)param) += 4;
        printf("Thread1: %d\n", *(int*)param);
        for(int i = 0; i < 4; ++ i)
            sem_post( &Poll_OUT);
        pthread_mutex_unlock(&Poll_Work);
         
        sleep(1);
    }
    return NULL;
}
 
void* thread2(void *param)                   //此线程用于将水从池中倒出。。
{
    while(1){
        int rv = 0;
        for(int i = 0; i < 3; ++ i)
            while((rv = sem_wait(&Poll_OUT)) != 0 && (errno == EINTR))      //减少当前水量
                printf("xx");
        pthread_mutex_lock(&Poll_Work);
        (*(int*)param) -= 3;
        printf("Thread2: %d\n", *(int*)param);
        for(int i = 0; i < 3; ++ i)
            sem_post(&Poll_IN);                                     //水池容量信号量增加
        pthread_mutex_unlock(&Poll_Work);
        sleep(1);
    }
    return NULL;
}
 
 
int main()
{
    int sum = 0;   //水深  满为100米 初始化 池里没有水
    int i;
 
    pthread_mutex_init(&Poll_Work, NULL);
    sem_init(&Poll_IN, 0, 100);
    sem_init(&Poll_OUT, 0, sum);
    pthread_t ths[4];
    pthread_create(&ths[0], NULL,  thread0, (void*)&sum);
    pthread_create(&ths[1], NULL,  thread1, (void*)&sum);
    pthread_create(&ths[2], NULL,  thread2, (void*)&sum);
    for(i = 0; i < 3; ++ i){
        pthread_join(ths[i], NULL);
    }
}
