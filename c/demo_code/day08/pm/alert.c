#include <signal.h>
#include <stdio.h>
#include <unistd.h>

void handle(int s)
{
	printf("定时器!\n");
}
main()
{
	//5秒后发送SIGALRM信号
	alarm(5);

	signal(SIGALRM,handle);
	while(1);
}
