#include <stdio.h>
#include <unistd.h>
#include <pthread.h>
 
int a = 200;
int b = 100;

pthread_mutex_t lock;
 
void* ThreadA(void *p)
{
    pthread_mutex_lock(&lock);     //锁
    a -= 50;
    sleep(2);                      //执行到一半 使用sleep 放弃cpu调度
    b += 60;
    pthread_mutex_unlock(&lock);
}
 
void* ThreadB(void *p)
{
    sleep(1);             //放弃CPU调度 目的先让A线程先运行。 此句不能注释掉
    pthread_mutex_lock(&lock);
    printf("%d\n", a + b);              
    pthread_mutex_unlock(&lock);
}
 
/*
    打印结果是 310 

    如果不优先让A线程运行，打印的结果可能是300 或 310
*/
int main()
{
    pthread_t tida, tidb;

    pthread_mutex_init(&lock, NULL);    //初始化互斥量

    pthread_create(&tida, NULL, ThreadA, NULL);     // 创建线程1
    pthread_create(&tidb, NULL, ThreadB, NULL);     // 创建线程2

    pthread_join(tida, NULL);   // 等待线程1结束
    pthread_join(tidb, NULL);   // 等待线程2结束

    return 1;
}
