/*  计算 1 - 10000 之间的和	*/
/* 屏蔽ctrl+c发出的SIGINT信号	*/

#include <signal.h>
#include <stdio.h>
#include <unistd.h>

void handle(int s)
{
	printf("处理ctrl+c!\n");

}

main()
{
	int sum = 0;
	int i;
	
	sigset_t masksigs;
	sigemptyset(&masksigs);

	/* 1.定义一个信号集合	*/
	sigset_t sigs;

	/* 2.添加 屏蔽 信号	*/
	sigemptyset(&sigs);
	sigaddset(&sigs,SIGINT);
	//	屏蔽所有的信号
	//	sigfillset(&sigs);

	/* 3.设置信号集合被屏蔽		*/
	signal(2,handle);

	sigprocmask(SIG_BLOCK,&sigs,0);

	/***********************************/
	for(i=0;i<21;i++)
	{
		sum += i;
		sleep(1);

		sigpending(&masksigs);
		if(sigismember(&masksigs,2))
		{
			sigprocmask(SIG_UNBLOCK,&sigs,0);
			sigprocmask(SIG_BLOCK,&sigs,0);
		}
	}

	printf("sum is %d\n",sum);
	printf("计算结束!\n");

	/*  解除信号屏蔽	*/
	sigprocmask(SIG_UNBLOCK,&sigs,0);

	/**********************************/

	printf("正常结束!\n");
}
