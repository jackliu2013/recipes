#include <stdio.h>

/* 判断输入的数是整数  */
int input(int a)
{
	if(a<0 || a ==0)
	{
		printf("the value is illegal.\n");
		return -1;
	}
	else
		return a;
}
