#include <stdio.h>
#include <unistd.h>

main()
{
	// int r=execl("ls",0);
	// int r=execlp("ls",0);
	// int r=execlp("ls","-l",0);
	int r=execlp("ls","-l","-l",0);
	printf("Ö´ÐÐÍê±Ï");
}
