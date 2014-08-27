#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

main()
{
	int fd;
	int *p;
	/* 1.打开文件	*/
	fd = open("map.dat",O_RDWR);
	if(fd == -1)
	{
		perror("open");
		exit(-1);
	}
	/* 2.映射虚拟地址	*/
	//映射为MAP_PRIVATE
	/*
	p == mmap(0,4,PROT_READ,
				MAP_PRIVATE,fd,0);
	*/

	//映射为MAP_SHARED
	p == mmap(0,4,PROT_READ|PROT_WRITE,
				MAP_SHARED,fd,0);
	if(!p)
	{
		perror("map");
		close(fd);
		exit(-1);
	}
	/* 3.打印虚拟地址中的数据	*/
	while(1)
	{
		printf("%d\n",*p);
		sleep(1);
	}

	/* 4.卸载虚拟的地址	*/
	munmap(p,4);

	/* 5.关闭文件	*/
	close(fd);

}
