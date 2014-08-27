#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>

struct book
{
	char name[32];
	char author[32];
	float price;
	int amount;
}

/* 存在就打开文件，不存在就创建文件	 */
int opendb(const char *file)
{
	if(file == NULL)
			return -1;
	int fd;
	fd = open(file,O_CREAT|O_RDWR,0666);
	if(fd == -1)
	{
		perror("opendb error,file cannot open");
		return -1;
	}
	return 0;
}

/* 映射文件	  */
void *mapdb(int fd)
{
	if(fd == -1)
		return -1;
	void *p;
	p = mmap(0,getpagesize(),
				PROT_READ|PROT_WRITE,
				MAP_SHARED,fd,0);
	if(p == (void *)0)
	{
		perror("mmap error.");
		exit(-1);
	}
	return p;
}

/* 输入保存一本书的信息  */
int inputbook(struct book *b)
{
	memset(b,0x00,sizeof(struct book));

	printf("请输入书的信息\n");
	
	printf("请输入书名\n");
	scanf("%s",b->name);

	printf("请输入书的作者\n");
	scanf("%s",b->author);

	printf("请输入书的价格\n");
	scanf("%f",b->price);

	printf("请输入书的余量\n");
	scanf("%d",b->amount);

	return 0;

}

/* 输入各种数据类型 */	
/* 将输入的数据转换成整数 */
void inputint(const char *info,int *n)
{
	if(info == NULL)
		return -1;
	
}
void inputstr(const char *info,char *str)
void inputch(const char *info,char *ch)
void inputfloat(const char *info,float *f)

/* 修改文件大小，增加一条记录的空间，返回整个文件的大小		*/
size_t addrecord();

main()
{
	int fd;
	struct book *b;
	char isover;
	size_t size;

	/* 1.打开或者创建文件 	*/
	fd = open("book.dat");
	b = mapdb(fd);

	while(1)
	{
		/* 2.输入图书信息	*/
		inputbook(b);

		/* 3.保存数据	*/
	  	szie=addrecord();

		/* 4.提示是否继续输入	*/
		inputchar("是否继续输入",&isover);
		if(isover!='y' || isover !='Y')
				break;

	}

	/* 5.释放关闭	*/
	munmap(*p,size);
	close(fd);
}
