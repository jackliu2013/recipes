#include <cstdio>
#include <cstdlib>
#include <unistd.h>
#include <pthread.h>
#include "iostream"
using namespace std;

/* 创建互斥量 */
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

int tmp;

void* thread(void *arg)
{
    cout << "thread id is " << pthread_self() << endl;
    pthread_mutex_lock(&mutex);
    tmp ++;
    cout << "Now a is " << tmp << endl;
    pthread_mutex_unlock(&mutex);
    return NULL;
}

int main()
{
    pthread_t id;
    cout << "main thread id is " << pthread_self() << endl;
    tmp = 3;
    cout << "In main func tmp = " << tmp << endl;
    if (!pthread_create(&id, NULL, thread, NULL))
    {
        cout << "Create thread success!" << endl;
    }
    else
    {
        cout << "Create thread failed!" << endl;
    }
    pthread_join(id, NULL);
    pthread_mutex_destroy(&mutex);
    return 0;
}
//编译：g++ -o thread testthread.cpp -lpthread


