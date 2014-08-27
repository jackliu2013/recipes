#include <stdio.h>

extern int input(int);

/* 判断整数a，b之间的素数并打印  */
void print(int a,int b)
{
		int i=0;

		for(i=a;i<b;i++)
		{
			if(judgeprime(i) > 0)
			{
				printf("%d\t",i);
			}
			continue;
		}
		printf("\n");
}

/* 判断一个数是不是素数  */
int judgeprime(int number)
{
	int i=0;
	for (i=2; i<number; i++)
	{
		if(number % i == 0)
			return -1;
	}
	return 1;
}
