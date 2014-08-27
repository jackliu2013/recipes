/*  接收处理信号	*/

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void handle(int s)
{
printf("处理信号:%d\n",s);

}

main()
{

	signal(SIGRTMIN,handle);
	while(1);

}
