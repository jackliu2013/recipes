#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>

main()
{

	int fd;
	int *p;
	/*	1. 创建一个文件 */
	fd = open("map.dat",O_RDWR|O_CREAT,0666);
	if(fd == -1)
	{
		perror("open");
		exit(-1);
	}	

	/*	2. 把文件大小设置为4字节 */
	ftruncate(fd,4);

	/*	3. 映射文件到虚拟内存	*/
	//映射为MAP_PRIVATE
	/*
	p=mmap(0,4,PROT_READ|PROT_WRITE,
			MAP_PRIVATE,fd,0); 
	*/

	
	//映射为MAP_SHARED
	p=mmap(0,4,PROT_READ|PROT_WRITE,
			MAP_SHARED,fd,0); 
	if(!p)
	{
		perror("mmap");
		close(fd);
		exit(-1);
	}

	/*	4. 保存一个数据到内存	*/
	int i=0;
	while(1)
	{
		*p = i;
		i++;
		sleep(1);
	}

	/* 	5.卸载映射	*/
	munmap(p,4);

	/*	6. 关闭文件	*/
	close(fd);

}
