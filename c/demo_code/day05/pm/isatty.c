#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

main()
{

	/* add */
	int fd;


	int r;
	r = isatty(1);

	/* add */
	fd = open("/dev/tty",O_RDWR);
	if(r == 1)
	{
		write(fd,"没用定向,直接输出\n",strlen("没用定向,直接输出\n"));
	}
	else
	{
		write(fd,"已经定向,但还是输出到终端\n",strlen("已经定向,但还是输出到终端\n"));
	}
}
