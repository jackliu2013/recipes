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
	/* 5.删除管道	*/
	unlink(pipefile);

	exit(0);

}

main()
{

	signal(2,closeproc);

	/* 1.建立管道文件	*/
	r = mkfifo(pipefile,0666);
	if(r == -1)
	{
		printf("mkfifo:%m\n");
		exit(-1);
	}

	/* 2.打开管道文件	*/
	fd = open(pipefile,O_RDWR);
	if(fd == -1)
	{
		printf("open:%m\n");
		unlink(pipefile);
		exit(-1);
	}

	/* 3.每隔一秒钟，写入一个数据	*/
	int  i=0;
	while(1)
	{
		write(fd,&i,sizeof(int));
		i++;
		read(fd,&r,sizeof(int));
		printf("::%d\n",r);
		sleep(1);
	}


}
