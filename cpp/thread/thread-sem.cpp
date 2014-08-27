#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <semaphore.h>

sem_t bin_sem;

void *thread_function1(void *arg)
{
     while (1)
     {
        printf("thread_function1--------------sem_wait\n");
        sem_wait(&bin_sem);
        printf("sem_wait\n");
     }
}

void *thread_function2(void *arg)
{
    int j = 0;
    while (1)
    {
        printf("thread_function2--------------sem_post\n");
        sem_post(&bin_sem);
        printf("sem_post\n");
        j++;
        if( 10 == j) 
        {
            printf("thread_function2 exit normally\n");
            return 0;
        }
    }
}


 
int main()
{
     int res;
     pthread_t a_thread, b_thread;
     void *thread_result;
     
     res = sem_init(&bin_sem, 0, 0);
     if (res != 0)
     {
        perror("Semaphore initialization failed");
     }
     printf("sem_init succeed\n");

     res = pthread_create(&a_thread, NULL, thread_function1, NULL);
     if (res != 0)
     {
        perror("Thread creation failure");
     }
     printf("thread_function1 succeed.\n");
     sleep (5);
     printf("sleep\n");

     res = pthread_create(&b_thread, NULL, thread_function2, NULL);
     if (res != 0)
     {
        perror("Thread creation failure");
     }
     printf("thread_function2 succeed.\n");

     while (1)
     {
    
     }
}
