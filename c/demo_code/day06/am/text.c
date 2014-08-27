#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

main()
{
	int fd;
	char filename[]="text.txt";
	char *name="tom"; //20
	int age=20; //4
	float score=88.99; //4
	char sex='m';//1

	char str[50];
	sprintf(str,"%20s %d %.2f %c\n",name,age,score,sex);

	/*
	fd = open(filename,O_RDWR|O_CREAT|O_EXCL,0666);
	*/
	fd = open(filename,O_RDWR|O_CREAT|O_TRUNC,0666);
	if(fd == -1)
	{
		perror("open error");
		exit(-1);
	}

	write(fd,str,strlen(str));

	close(fd);
}
