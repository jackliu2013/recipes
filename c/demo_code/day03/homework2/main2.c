#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

/*
* 	通过调用/lib/libdl.so中的dlopen,dlsym,dlclose来进行动态库的调用
*/
int main()
{
	int m;
	void (*p)()=NULL;
	void *h;
	do
	{
		printf("请输入选项：\n");
		printf("1.打印菱形\n");
		printf("2.打印乘法表\n");
		printf("3.退出\n");
		scanf("%d",&m);
		printf("%d\n",m);
		if( m>3 || m<0)
		{
			printf("输入不合法，请重新输入\n");
		}
	}while( m>4 || m <0);

	/* 打开动态库 */	
	h = dlopen("libdlku.so",RTLD_LAZY);
	if(!h)
	{
	     printf("load error\n");
	     exit(-1);
	 }
	
	/* 根据输入确定查找的函数名 */
	if( m ==1)
		p=dlsym(h,"print_rhombus");
	else if (m==2)
		p=dlsym(h,"print_cf");
	else if (m == 3)
		exit(0);
	
	if(!p)
	{
		printf("look error\n");
		exit(-1);
	}
	p();

	/*  关闭共享库 close the .so */
	dlclose(h);

	return 0;
}
