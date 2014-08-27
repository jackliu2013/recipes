#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

main()
{
	//获取1的状态标记 1是标准输出 
	int st=fcntl(1,F_GETFL);
	if(st & O_RDONLY)
	{
		printf("only read\n");
	}
	if(st & O_WRONLY)
	{
		printf("only write\n");
	}
	if(st & O_RDWR)
	{
		printf("read and write\n");
	}
}
