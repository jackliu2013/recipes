#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>

main()
{

	printf("uid:%d,\teuid:%d\n",
			getuid(),geteuid());
	int fd = open("text.txt",O_RDWR);
	if(fd == -1)
	{
		printf("error:%m\n");
		exit(-1);
	}
	printf("no problem\n");

	close(fd);
}
