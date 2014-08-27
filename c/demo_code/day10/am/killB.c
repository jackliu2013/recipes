/* 循环发送20次信号   */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

main()
{
	int i;
	for(i=0;i<5;i++)
	{
		kill(5564,34);
	}
}
