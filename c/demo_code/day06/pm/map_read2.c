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
	fd = open("book.dat",O_RDONLY);	
	if(fd == -1)
	{
		/*
		perror("open error.");
		*/
		printf("errno is %d\terrmsg is %s\n",errno,strerror(errno));
		exit(-1);
	}
	/* 2.映射文件到虚拟内存		*/
	/* 此处映射的内存的权限应与open中文件的权限一样 如同位读	*/
	/* 不能设置写权限，否则系统会报段错误	*/
	p = mmap(0,getpagesize(),
			PROT_READ,
			MAP_SHARED,fd,0);//最后参数必须是page的倍数
	if(p == (void *)0)
	{
		printf("errno is %d\terrmsg is %s\n",errno,strerror(errno));
		exit(-1);
	}
	/* 打印映射内存的地址 */
	printf("0x%p\n",p);

	/* 3.操作虚拟地址 	*/
	int age=0; 			// 4bytes
	float score=0;		// 4bytes
	char sex;			// 1bytes
	char name[20]={0};  // 20bytes

	void *ptmp = p;
	memcpy(name,ptmp,3);
	memcpy(&age,ptmp+20,sizeof(int));
	memcpy(&score,ptmp+24,sizeof(float));
	memcpy(&sex,ptmp+28,sizeof(char));
	printf("%s\t%d\t%.2f\t%c\n",name,age,score,sex);

	memcpy(name,ptmp+29,4);
	memcpy(&age,ptmp+49,sizeof(int));
	memcpy(&score,ptmp+53,sizeof(float));
	memcpy(&sex,ptmp+57,sizeof(char));
	printf("%s\t%d\t%.2f\t%c\n",name,age,score,sex);

	/* 4.卸载虚拟地址	*/
	munmap(p,getpagesize());

	/* 5.关闭文件		*/
	close(fd);	
	
}
