#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

main()
{
	int fd;
	off_t pos;

	/* 1.打开一个文件 */
	fd = open("text.txt",O_RDWR);

	/* 2.得到当前位置 */
	pos = lseek(fd,0,SEEK_CUR);
	printf(" the cur location is %d\n",pos);

	/* 3.移动  位置 */
	pos = lseek(fd,300,SEEK_SET);

	/* 得到位置 */
	printf(" the cur location is %d\n",pos);

	/* 5.关闭文件,查看文件的大小是否改变 */
	close(fd);
}
