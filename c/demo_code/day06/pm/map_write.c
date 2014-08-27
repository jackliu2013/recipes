#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <errno.h>

main()
{
	
	int fd;
	void *p;

	/* 1.创建一个文件	 */	
	fd = open("book.dat",O_RDWR|O_CREAT,0666);	
	if(fd == -1)
	{
		/*
		perror("open error.");
		*/
		printf("errno is %d\terrmsg is %s\n",errno,strerror(errno));
		exit(-1);
	}
	/* 2.映射文件到虚拟内存		*/
	/* 此处映射的内存的权限应与open中文件的权限一样 如同位读写 		*/
	p = mmap(0,getpagesize(),
			PROT_READ|PROT_WRITE,
			MAP_SHARED,fd,0);//最后参数必须是page的倍数
	if(p == (void *)0)
	{
		printf("errno is %d\terrmsg is %s\n",errno,strerror(errno));
		exit(-1);
	}
	/* 打印映射内存的地址 */
	printf("0x%p\n",p);

	/* 给文件指定一个大小,是文件大小不为0，  否则会报bus error总线错误 */
	ftruncate(fd,20);

	/* 3.操作虚拟地址 	*/
	// *((int *)p) = 20;
	memcpy(p,"Hello World,Hello World,Hello World",36);

	/* 4.卸载虚拟地址	*/
	munmap(p,getpagesize());

	/* 5.关闭文件		*/
	close(fd);	
	
}
