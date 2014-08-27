#include <stdio.h>
#include <unistd.h>

/* 文件操作头文件 */
#include <fcntl.h> 
#include <stdlib.h>
#include <string.h>

main()
{
	
	int fd;
	char name[20];
	int age;
	float score;
	char sex;
	char *filename="a.dat";
	
	/* 1.打开文件 */
	fd = open(filename,O_RDWR);
	if(fd == -1)
	{
			/*
		printf("open error:%m\n",);
			*/
			perror("open error");
			exit(-1);
	}
	
	/* 2.循环读取数据 */

	int r;
	while(1)
	{
		r = read(fd,name,sizeof(name));
		if(r<=0)
				break;
		r = read(fd,&age,sizeof(int));
		r = read(fd,&score,sizeof(float));
		r = read(fd,&sex,sizeof(char));

		printf("%s,%d,%5.2f,%c\n",name,age,score,sex);
	}
	/* 3. 关闭文件  */
	close(fd);	
}
