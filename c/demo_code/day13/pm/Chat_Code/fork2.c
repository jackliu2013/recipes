#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

main()
{
	int a[5]={1,2,3,4,5};

	int idx=0;
	int i;

	printf("%d\n",a[idx]);
	idx ++;
	for(i=0;i<5;i++)
	{
		if(fork())
		{
			//idx ++;
			continue;
		}
		else
		{
			printf("idx=%d\n",idx);
			exit(0);	//子进程退出
		}
	}

}
