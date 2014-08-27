#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

main()
{
	int fd;
	fd = open("fd.txt",O_RDWR);
	if(fd==-1) perror("open"),exit(-1);
	if(fork())
	{
		//父进程
		write(fd,"hello",strlen("hello"));
		sleep(5);
	}
	else
	{
		//子进程
		write(fd,"world ltl",strlen("world ltl"));
		sleep(5);
	}

	close(fd);

}
