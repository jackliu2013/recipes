#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

int a = 9999;

main()
{
	int b=8888;
	int fd;
	char filename[128]={0};

	/* 得到程序的内存映射描述符号 */
	sprintf(filename,"/proc/%d/mem",getpid());

	fd = open(filename,O_RDWR);

	int r;
	
	pread(fd,&r,4,(off_t)&b);
	printf("%d\n",r);

	pread(fd,&r,4,(off_t)&a);
	printf("%d\n",r);
	
	close(fd);
}
