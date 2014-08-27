#include <stdio.h>
#include <stdlib.h>

main()
{
	int *a;
	int *p;

	a=(int *)0xbfae9e2c;
	p=(int *)0x993a008;

	printf("%d\n",*a);
	printf("%d\n",*p);

}
