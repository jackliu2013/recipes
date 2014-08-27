#include <unistd.h>
#include <sys/stat.h>
#include <stdio.h>
#include <fcntl.h>

main()
{
	int fd;
	struct stat st;
	int r;

	/* 1. 打开文件  */
	fd = open("text.txt",O_RDONLY);

	/* 2. 返回文件信息 */
	r = fstat(fd,&st);
	if (r == -1)
	{
		perror("fstat error.");
	}
	else
	/* 3. 打印文件信息 */
	{
		printf("size:%d,\tmode:%05o\n",
				st.st_size,st.st_mode);
	}

	/* 4. 关闭文件 */
	close(fd);
}
