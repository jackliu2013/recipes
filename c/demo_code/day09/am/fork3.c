#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
main()
{	
	printf("This is parent process%d\n",getpid());
	pid_t p1,p2;
	int i;

	// 循环3次，产生3个子进程
	for(i=0;i<=2;i++)
	{
		if((p1=fork())==0)
		{
			printf("This is child%d:%d\n",i,getpid());
			return 0;//这个地方非常关键
		}
		//父进程等待p1进程执行后,才能继续fork其他子进程	
		wait(p1,NULL,0);		
	}

	printf("This is parent process%d\n",getpid());

}
