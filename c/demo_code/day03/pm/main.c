#include <stdio.h>

extern int input(char *);
extern int diamond(char *);
int main(int argc,char **argv)
{
	printf("the main function is begin.\n");
	printf("please input a value above zero\n");
	int b,c;
	b=c=0;
	char a;
	a = getchar();
	b = input(&a);
	c = diamond(&a);

	printf("the main function is end.\n");
	return 0;
}
