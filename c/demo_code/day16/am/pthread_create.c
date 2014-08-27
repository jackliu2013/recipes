#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sched.h>
 
void *run(void *data)
{
    //while(1)
    //{
        printf("this is child pthread!\n");
        printf("receive data from main thread::%s\n",data);
        //sched_yield();    /* ¿¿CPU */
        //sleep(1);
    //}
    return "world";
}
 
main()
{
    pthread_t tid;
    /* ¿¿¿¿, ¿¿¿¿¿¿¿¿¿¿¿
    int r=pthread_create(&tid,0,run,0);
    */
    /* ¿¿¿¿, ¿¿¿¿¿¿¿¿¿¿ */
    int r=pthread_create(&tid,0,run,"hello");
    if(r)
    {
        printf("create thread success!\n");
    }
    //while(1)
    //{
        printf("this is main thread!\n");
        //sched_yield();    /* ¿¿CPU */
        //sleep(1);
    //}
 
    /* receive data from child thread */
    char *buf;
    pthread_join(tid,(void **)&buf);
    printf("receive data from child pthread:%s\n",buf);
     
    /* ¿¿¿¿¿¿¿¿¿   
    pthread_join(tid,(void **)0);
    */
}
