#include <stdio.h>

int input(int);
void print(int,int);
int judgeprime(int);

#define a(m) #m
#define b(m) 12##m

int main(int argc,char **argv)
{
	printf("the main is begin.\n");
	printf("please input the value above zero\n");
	int a,b;
	scanf("%d %d",&a,&b);
	a = input(a);
	b = input(b);
	if (a >= b)
	{
			print(b,a);
	}
	else
			print(a,b);
	printf("the a(m) is %s\n",a(hello));
	printf("the b(m) is %d\n",b(12));
	printf("the line num is %d\n",__LINE__);
	printf("the time is %s\n",__TIME__);
	printf("the date is %s\n",__DATE__);
	printf("the function name is %s\n",__func__);
	printf("the file name is %s\n",__FILE__);
	return 1;

}
