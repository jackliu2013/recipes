#include <stdio.h>

int diamond(char *q)
{
	char *p=q;
	if(*p)
	{
		printf("this is a diamond.\n");
		return 1;
	}
	else
	{
		printf("this is not a diamond.\n");
		return -1;
	}

}
