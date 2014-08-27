#include <stdio.h>
#include <unistd.h>

main()
{
		/*
	int newfd = dup(1);
	*/
	int newfd =100 ;
	dup2(1,newfd);
	printf("%d\n",newfd);

	write(100,"hello\n",6);

	printf("pid:%d\n",getpid());

	while(1);
}
