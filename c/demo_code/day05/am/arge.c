#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
extern char **environ;

/*main函数参数 
*argc :参数个数
*argv :参数值指针 ,是指针的指针
*arge :环境变量，是指针的指针
*/
int main(int argc,char **argv,char **arge)
{
	/*
	while( arge && *arge)
	{
		printf("%s\n",*arge);
		arge ++;
	}
	*/

	/*
	int i=0;
	while( arge && arge[i])
	{
		printf("%s\t",arge[i]);
		printf("%x\n",arge[i]);
		i++;
	}
	*/

	/*
	while( environ && *environ )
	{
		printf("%s\n",*environ);
		environ ++;
	}
	*/

	printf("%s\n",getenv("PATH"));
	printf("logname is %s\n",getenv("LOGNAME"));
	return 0;

}
