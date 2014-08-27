#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#include <string.h>
/* memset,memcpy,需要string头文件 */

main()
{
	char *str=mmap(
				0,//系统指定映射的首地址
				1*getpagesize(),//映射的大小
				PROT_READ|PROT_WRITE,//映射的权限
				MAP_SHARED|MAP_ANONYMOUS,//方式
				0,0);

	memset(str,0x00,1*getpagesize());
	memcpy(str,"Hello World!",12);
	
	printf("%s\n",str);
	munmap(str,1*getpagesize());

}

