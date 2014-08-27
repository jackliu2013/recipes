#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

void handle(int s)
{

	printf("处理中断...\n");
	sleep(10);
	printf("中断处理完毕!\n");
}

main()
{
	signal(3,handle);

	while(1);
}

/*
* 连续发送两次 3中断信号
*/

/*
* 发一次3中断信号，再发送一个其他信号
*/
