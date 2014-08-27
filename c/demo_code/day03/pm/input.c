#include <stdio.h>

int input(char *q)
{
	char *p=q;
	if (*p<0)
	{
		printf("input value is illegal.\n");
		return -1;
	}
	else
		return *p;
}
