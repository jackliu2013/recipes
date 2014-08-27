#include "userdata.h"

/* 构造函数实现	*/
UserData::UserData()
{
	/* 互斥量和条件量的初始化	*/
	pthread_mutex_init(&mutex,0);
	pthread_cond_init(&cond,0);
	/* 此处没有实现异常处理	*/
}

/* 析构函数实现		*/
UserData::~UserData()
{
	/* 互斥量和条件量的释放		*/
	pthread_mutex_destroy(&mutex);
	pthread_cond_destroy(&cond);
}

/*	向队列 写数据	*/
/*	加互斥锁的时候，是单个线程写数据	
*  	不加互斥锁的时候，多个线程可同时
*  	写入数据
*/
void UserData::push_data(int num)
{
	pthread_mutex_lock(&mutex);

	data.push_back(num);
	printf("放入数据:%d,并通知\n",num);
	pthread_cond_broadcast(&cond);
	
	pthread_mutex_unlock(&mutex);
}

int UserData::pop_data()
{
	int ret;
	pthread_mutex_lock(&mutex);

	while(data.empty())
	{
		printf("没有数据,等待中......\n");
		pthread_cond_wait(&cond,&mutex);
	}
	ret=data.back();
	data.pop_back();
	pthread_mutex_unlock(&mutex);	//放在这里才是正确的

	return ret;
//	pthread_mutex_unlock(&mutex); 放在这里会产生死锁
}
