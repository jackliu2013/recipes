
#include <stdio.h>
#include <stdlib.h>

main()
{
		int a =9999;
		int *p=malloc(4);

		*p=8888;

		printf("%x\n",&a);
		printf("%x\n",p);

		while(1);
}
