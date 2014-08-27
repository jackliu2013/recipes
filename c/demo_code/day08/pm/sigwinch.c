#include <stdio.h>
#include <signal.h>

void handle(int s)
{
	printf("´°Ìו¸Ä±ה!\n");
}
main()
{
	signal(SIGWINCH,handle);
	while(1);
}
