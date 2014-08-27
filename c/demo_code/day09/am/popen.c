#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>

main()
{
	
	/* 加载程序，打通管道	*/
	//以只读方式建立管道
	//	FILE *f = popen("test.sh","r"); 

	//以只写方式建立管道
	FILE *f = popen("test.sh","w"); //以只写方式建立管道
	if(!f)
	{
		perror("popen error");
		exit(-1);
	}

	/* 把 f 转换成文件描述符号	*/
	int fd = fileno(f);
	//写数据
	write(fd,"Killer\n",7);

	/* for read info
	char buf[256];
	int r;
	while(1)
	{
		//读取来自test.sh 运行的标准输出
		bzero(buf,sizeof(buf));
		r = read(fd,buf,sizeof(buf)-1);
		if(r<=0)
			break;
		printf("buf is [%s]\n",buf);
	}
 	read end	*/

	/* 关闭文件与通道 	*/
	pclose(f);
}
