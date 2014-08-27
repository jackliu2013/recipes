#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

main()
{

	int fd;

	struct stat st;
	int i;

	/* 登录名	*/
	char logname[32];
	/* 记录条数	*/
	int count;

	/* 1.打开文件	*/
	fd = open("wtmpx",O_RDWR);
	if(fd == -1)
	{
			perror("open error");
			exit(-1);
	}

	/* 2.获取记录条数	*/
	/* 文件长度大小/每条记录所占用的空间大小	*/
	fstat(fd,&st);
	count = st.st_size/372 ;

	/* 3.循环读取记录, 并打印出来	*/
	for(i=0;i<count;i++)
	{
		lseek(fd, i*372 ,SEEK_SET);
		read(fd,logname,32);	
		printf("logname is %s\n",logname);
	}

	/* 4.关闭文件	*/
	close(fd);
}
