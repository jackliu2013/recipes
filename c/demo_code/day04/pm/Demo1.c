#include <stdio.h>
#include <unistd.h>

/* 判断一个数是否是素数  */
int isprimer(int a)
{
	int i;
	for(i=2;i<a;i++)
	{
		/* 合数 */
		if(a%i==0)
			return 1;
	}

	return 0; /* 素数 */
}

main()
{
	/* 1. 先找到一个首地址 */
		int *pstart=sbrk(0);
		int *p; /* 记录当前地址 */
		p=pstart;

	/* 2. 循环找素数，找到就分配4字节，把素数存放进去 */
	
		int i;
		for(i=2;i<10000;i++)
		{
			if(!isprimer(i))
			{
				brk(p+1);
				*p=i;
				p=sbrk(0); /* 返回上次的末尾地址  */
			}
		}

	/* 3. 得到末尾地址 */
	int *pend = sbrk(0);

	/* 4. 循环内存，打印所有素数 */
	p = pstart;
	while(p!=pend)
	{
		printf("%d\n",*p);
		p++;
	}

	printf("the num of the primer is %d\n",(pend-pstart));
	/* 5. 释放空间 */
	brk(pstart);
}

