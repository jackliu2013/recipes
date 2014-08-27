#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>

main()
{
	fd_set fds;//描述符集合
	FD_ZERO(&fds);	//清空描述符集合
	FD_SET(0,&fds);	//把标准输入描述符号0添加到描述符集合

	int r=select(1,&fds,0,0,0);
	if(FD_ISSET(0,&fds))
	{
		printf("有人输入!\n");
		char buf[20]={};
		read(0,buf,sizeof(buf)-1);
		printf("输入的是:%s",buf);
	}

}
