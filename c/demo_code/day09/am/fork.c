#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

main()
{
	int a=30;
	int *ip=malloc(4);
	*ip=10;

	int *c=sbrk(4);
	*c=8;

	/*映射的空间为MAP_PRIVATE私有映射,私有映射的空间，父子进程互不影响
	int *d=mmap(0,4,PROT_READ|PROT_WRITE,
					MAP_ANONYMOUS|MAP_PRIVATE,0,0);
	*/

	/* 映射的空间MAP_SHARED公有映射,公有映射的空间，父子进程相互影响 */
	int *d=mmap(0,4,PROT_READ|PROT_WRITE,
					MAP_ANONYMOUS|MAP_SHARED,0,0);
	printf("%m\n");
	
	*d=7;

	printf("父进程!\n");

	pid_t pid=fork();

	//printf("创建子进程:%d\n",pid);
	if(pid > 0)
	{
		while(1)
		{
			printf("父进程：%d\n",pid);
			a = 999;
			*ip = 999;
			*c = 999;
			*d = 7777;
			sleep(10);
		}
	}
	if(pid == 0)
	{
		while(1)
		{
			printf("子进程：%d\n",pid);
			printf("a:%d\n",a);
			printf("*ip:%d\n",*ip);
			printf("*c:%d\n",*c);
			printf("*d:%d\n",*d);
			sleep(2);
		}
	}
	if(pid ==-1)
	{	
		perror("fork");
		exit(-1);
	}

}
