#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <unistd.h>

/*
*	新 版本的信号处理函数
*/
void handle(int s,siginfo_t *info,void * m)
{
	printf("开始屏蔽处理!\n");

	printf("%d:%d\n",info->si_pid,info->si_int);

	sleep(2);
	printf("屏蔽处理完毕!\n");
}

main()
{
	/* 定义初始化信号处理结构体	*/
	struct sigaction act={0};
	/* sigaction 结构体的第一个成员	*/
//	act.sa_handler=handle;
	
	/* sigaction 结构体的第二个成员	*/
	act.sa_sigaction=handle;

	/* 中断函数在执行时被 屏蔽信号10 	*/
	sigemptyset(&act.sa_mask);
	sigaddset(&act.sa_mask,SIGUSR1);
	
	/* 使用老版本的信号处理函数	*/
	//act.sa_flags = 0;

	// 为了能传递数据,使用siginfo_t结构体
	//优先调用新版本的处理函数
	act.sa_flags = SA_SIGINFO;

	printf("::%d\n",getpid());

	sigaction(2,&act,0);

	while(1);

}
