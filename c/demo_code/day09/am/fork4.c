#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

/* 
* 
*
*/
main()
{	
	printf("parent process:%d begin\n",getpid());
	pid_t p1,p2;
	int i;
	int status;

	//	循环3次一共产生7个子进程，但是只有3个子进程
	//	是父进程产生的，剩下的都是子进程fork出来的
	for(i=0;i<=2;i++)
	{
		p1 = fork();
		if( p1==0 )
		{
			printf("child%d pid:%d\n",i,getpid());
	//		exit(0);
		}
		else if(p1 > 0)
		{
			printf("parent pid:%d\tppid:%d\n",getpid(),getppid());
		}
		p2 = wait(p1,&status,0);		
	}
	printf("parent process%d end\n",getpid());
}
