#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

main()
{
	int r;
	
	//r=system("ls -l");

	printf("调用进程ID:%d\n",getpid());

	r = system("testa");	
	// r=system("a.sh");

	//r右移8位 , 然后与255进行且的位运算
	//printf("==%d\n",r>>8&255);


	printf("==%d\n",WEXITSTATUS(r));
}
