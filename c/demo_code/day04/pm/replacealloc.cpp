#include <cstdio>
#include <cstdlib>
#include <new>

int main()
{
	char *c=(char *)malloc(2);

	/* 如果4比c的空间小,则在c的空间内以c开始的地址申请4个空间的大小,同时释
		放多余的空间
		如果4比c的空间大，则在内存中释放c的空间，重新在内存中寻找一个
		比较大的空间来申请4个空间
	*/
	int *p=(int *)realloc(c,4);


	char *c2=new char[2];
	int *p2=new(c2) int(100);


	printf("the addr of c is %x\n",c);
	printf("the addr of p is %x\n",p);


	printf("the addr of c2 is %x\n",c2);
	printf("the addr of p2 is %x\n",p2);
	return 0;
}
