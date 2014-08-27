#ifndef MY_THREAD_H
#define MY_THREAD_H

#include <pthread.h>

class MyThread
{
	private:
		pthread_t tid;
		static void *s_run(void *d);	//线程执行的代码
	public:
		void start();	//启动线程
		void join();	// 等待线程结束	
	public:
		virtual	void run();	//虚函数 线程执行
};

#endif
