#include <stdio.h>
#include <unistd.h>

main()
{
	char buf[256];
	int r;

	r = read(0,buf,sizeof(buf));

	if(r == 0)
	{
		printf("输入终止符号\n");
	}

	if(r>0)
	{
		buf[r]='\0';
		printf("输入数据：%s\n",buf);
	}

	if(r == -1)
	{
		printf("设备故障\n");
	}
}
