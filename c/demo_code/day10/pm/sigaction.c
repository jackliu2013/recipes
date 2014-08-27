#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

/*
*	老版本的信号处理函数
*/
void handle(int s)
{
	printf("开始屏蔽处理!\n");
	sleep(5);
	printf("屏蔽处理完毕!\n");
}

main()
{
	/* 定义初始化信号处理结构体	*/
	struct sigaction act={0};
	act.sa_handler=handle;

	/* 中断函数在执行时被 屏蔽信号10 	*/
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask,SIGUSR1);
	
	/* 使用老版本的信号处理函数	*/
	act.sa_flags = 0;
	printf("::%d\n",getpid());

	sigaction(2,&act,0);
	//signal(2,handle);

	while(1);

}
