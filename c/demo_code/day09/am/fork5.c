#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
main()
{	
	printf("This is parent:%d\n",getpid());

	int i;
	pid_t pid[3];

	//循环三次，产生3个子进程
	for(i=0;i<3;i++)
	{
		if((pid[i]=fork()) == 0)
		{
				break;
		}
		else
			printf("child%d:%d\n",i,pid[i]);
	}
}
