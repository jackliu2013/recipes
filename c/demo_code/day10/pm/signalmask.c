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
	signal(2,handle);

	while(1);
}

/*
*	连续按两次ctrl+c
*/

/*
*	按一次ctrl+c,	发送SINGUSR1信号
*/
