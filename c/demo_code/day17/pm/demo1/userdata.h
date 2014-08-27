#ifndef DATA_CONTAINER_H
#define DATA_CONTAINER_H

#include <deque>
#include <pthread.h>
using namespace std;

class UserData
{
	private:
		deque<int> data;		
		pthread_mutex_t mutex;
		pthread_cond_t cond;
	public:
		/* 压缩数据	*/
		void push_data(int num);		
		/* 弹出数据	*/
		int pop_data();	

		/* 构造函数	*/
		UserData();
		/* 析构函数	*/
		~UserData();
};

#endif
