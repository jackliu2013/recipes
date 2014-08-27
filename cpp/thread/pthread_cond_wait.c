#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
 
static pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
 
struct node
{
    int n_number;
    struct node *n_next;
} *head = NULL; /*[thread_func]*/
 
/*释放节点内存 */
static void cleanup_handler(void *arg)
{
    printf("Cleanup handler of second thread.\n");
    free(arg);
    (void)pthread_mutex_unlock(&mtx);
}
 
static void *thread_func(void *arg)
{
    struct node *p = NULL;
    pthread_cleanup_push(cleanup_handler, p);
     
    while (1)
    {
        pthread_mutex_lock(&mtx);
        //这个mutex_lock主要是用来保护wait等待临界时期的情况，
        //当在wait为放入队列时，这时，已经存在Head条件等待激活
        //的条件，此时可能会漏掉这种处理
        //这个while要特别说明一下，单个pthread_cond_wait功能很完善，
        //为何这里要有一个while (head == NULL)呢？因为pthread_cond_wait
        //里的线程可能会被意外唤醒，如果这个时候head != NULL，
        //则不是我们想要的情况。这个时候，
        //应该让线程继续进入pthread_cond_wait
         
        while (head != NULL)
        {
            pthread_cond_wait(&cond, &mtx);
            // pthread_cond_wait会先解除之前的pthread_mutex_lock锁定的mtx，
            //然后阻塞在等待队列里休眠，直到再次被唤醒
            //（大多数情况下是等待的条件成立而被唤醒，唤醒后，
            //该进程会先锁定先pthread_mutex_lock(&mtx);，
            // 再读取资源 用这个流程是比较清楚的
            /*block-->unlock-->wait() return-->lock*/
             
            p = head;
            head = head->n_next;
            printf("Got %d from front of queue\n", p->n_number);
            free(p);
        }
        pthread_mutex_unlock(&mtx); //临界区数据操作完毕，释放互斥锁
 
    }
     
    pthread_cleanup_pop(0);
    return 0;
}
 
int main(void)
{
    pthread_t tid;
    int i;
    struct node *p;
    pthread_create(&tid, NULL, thread_func, NULL);
    //子线程会一直等待资源，类似生产者和消费者，
    //但是这里的消费者可以是多个消费者，
    //而不仅仅支持普通的单个消费者，这个模型虽然简单，
    //但是很强大
    for (i = 0; i < 10; i++)
    {
        p = (struct node *)malloc(sizeof(struct node));
        p->n_number = i;
        pthread_mutex_lock(&mtx); //需要操作head这个临界资源，先加锁，
        p->n_next = head;
        head = p;
        pthread_cond_signal(&cond);
        pthread_mutex_unlock(&mtx); //解锁
        sleep(1);
    }
    printf("thread 1 wanna end the cancel thread 2.\n");
    pthread_cancel(tid);
    //关于pthread_cancel，有一点额外的说明，它是从外部终止子线程，
    //子线程会在最近的取消点，退出线程，而在我们的代码里，最近的
    //取消点肯定就是pthread_cond_wait()了。
    pthread_join(tid, NULL);
    printf("All done -- exiting\n");
    return 0;
}
