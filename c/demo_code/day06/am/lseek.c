#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

main()
{
	int fd;
	char str[25];
	off_t pos;
	/* 实际读取的个数 */
	int rlen;

	/* 1.打开一个文本文件 */
	fd = open("text.c",O_RDONLY);

	/* 2.使用read读取几个字符，并打印当前的位置 */
	pos = lseek(fd,0,SEEK_CUR);
	printf(" the cur location is %d\n",pos);
	/* 在当前位置 读取5个字符 */
	read(fd,str,5);
	/* 再次打印当前的文件位置 */
	pos = lseek(fd,0,SEEK_CUR);
	printf(" the cur location is %d\n",pos);

	/* 3.使用pread读取几个字符，并打印当前的位置 */
	pos = lseek(fd,0,SEEK_CUR);
	printf(" the cur location is %d\n",pos);
	/* 在文件位置为10的时候 读取5个字符 */
	pread(fd,str,5,10);
	/* 再次打印当前的文件位置 */
	pos = lseek(fd,0,SEEK_CUR);
	printf(" the cur location is %d\n",pos);

	/* 4.关闭文件 */
	close(fd);
}
