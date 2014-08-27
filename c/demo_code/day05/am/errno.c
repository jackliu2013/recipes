#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

main()
{
	int *p=malloc(4294967295u);

	if(!p)
	{	
		/*
		printf("no enough memory\n");
		*/
		printf("%d\t%d\n",errno,ENOMEM);
		printf("%m\n");
		perror("no memory");
		printf("%s\n",strerror(ENOMEM));
	}


}
