#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sched.h>
 
void *run(void *data)
{
	int *p = (int *) data;
    //while(1)
    //{
        printf("this is child pthread!\n");
        printf("receive data from main thread::%d %d\n",p[0], p[1]);
        //sched_yield();    /* ¿¿CPU */
        //sleep(1);
    //}
    return "world";
}
 
main()
{
    pthread_t tid;
	printf("please input two integer\n");
	int arr[2] = {0};
	scanf("%d %d", &arr[0], &arr[1]);
    /* ¿¿¿¿, ¿¿¿¿¿¿¿¿¿¿¿
    int r=pthread_create(&tid,0,run,0);
    */
    /* ¿¿¿¿, ¿¿¿¿¿¿¿¿¿¿ */
    int r=pthread_create(&tid,0,run, (void *)arr);
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
