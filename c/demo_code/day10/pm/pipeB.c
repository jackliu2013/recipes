#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>

char pipefile[]="p.pipe"; //管道文件名
int fd;	//打开管道的文件描述符号
int r ;

void closeproc(int s)
{
	/* 4.关闭管道	*/
	close(fd);
	exit(0);

}

main()
{

	signal(2,closeproc);

	/* 2.打开管道文件	*/
	fd = open(pipefile,O_RDWR);
	if(fd == -1)
	{
		printf("open:%m\n");
		unlink(pipefile);
		exit(-1);
	}

	/* 3.每隔一秒钟，读取 一个数据	*/
	while(1)
	{
		read(fd,&r,sizeof(int));
		printf("%d\n",r);
	}

}
