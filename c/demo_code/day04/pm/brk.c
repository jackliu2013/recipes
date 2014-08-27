#include <stdio.h>
#include <unistd.h>


main()
{
	int *p=sbrk(0);
	/* 1.确定一个大块空闲空间的首地址
	   2.并且把首地址赋值给[开始地址]
	   3.并且根据参数0，把末尾地址赋值为=开始地址+0
	   4.返回开始地址
	   基本规则：开始地址和结束地址之间没有映射空间，系统自动映射,
	   映射单位是1page.
	   	size_t getpagesize();返回page大小
	*/
	printf("%x\n",p);


	int *p2=sbrk(4);
	/* 
		sbrk第二次运行
		1.把上次的末尾地址作为首地址
		2.把末尾地址赋值为=首地址+参数
		3.返回首地址
		参数可以是>0,<0,=0的任何数
		>0:分配空间
		<0:释放空间
	*/
	int *p3=sbrk(4);
	int *p4=sbrk(4);
	printf("%x\n",p2);
	printf("%x\n",p3);
	printf("%x\n",p4);
	/*
	sbrk(-4);
	*/

	*p2=10;
	printf("%d\n",*p2);
}
