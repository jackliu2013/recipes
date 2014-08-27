#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>

int main()
{
	/* 准备步骤 定义两个指针 */
	/* 定义函数指针指向add函数 function pointer */
	int (*padd)(int,int);
	/* 定义万能指针 */	
	void *h;

	/* 1. 打开加载共享库 first open and load the .so */
	h = dlopen("libku.so",RTLD_LAZY);
	if(!h)
	{
		printf("load error\n");
		exit(-1);
	}
	/* 2. 查找函数 second look the function */
	padd = dlsym(h,"add");
	if(!padd)
	{
		printf("look error\n");
		exit(-1);
	}

	/* 调用函数 call the function */
	int r = padd(45,55);
	printf("::%d\n",r);
	
	/*  关闭共享库 close the .so */
	dlclose(h);
	return 0;
}
