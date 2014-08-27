#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

main()
{

	int fd ;

	/* 1.打开文件 */
	fd = open("text.txt",O_RDWR);	

	/* 2.改变文件大小 */
	ftruncate(fd,20);

	/* 3.关闭文件 */
	close(fd);

}
