#include <unistd.h>
#include <stdio.h>

main()
{
	int fd[2]={0};

	pipe(fd);

	if(fork())
	{
		//父进程
		//fd[0] reading
		//fd[1]	writing 
		//关闭读
		close(fd[0]);
		while(1)
		{
			write(fd[1],"hello",5);
			sleep(1);
		}

	}
	else
	{
		//子进程
		//fd[0] reading
		//fd[1]	writing 
		//关闭写
		close(fd[1]);
		char buf[10];
		int r;
		while(1)
		{
			r = read(fd[0],buf,sizeof(buf)-1);
			buf[r]=0;
			printf("::%s\n",buf);
		}

	}
}
