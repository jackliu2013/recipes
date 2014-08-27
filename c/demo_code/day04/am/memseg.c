/* memseg.c  memorysegment.c */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int a =10;
static b = 20;
const c=30;
int add(int a,int b)
{
	return a+b;
}

main()
{
		int d =40;
		static int e =50;
		const int f = 60;

		int *p1=malloc(4);
		int *p2=malloc(4);
		
		printf("a=%x\n",&a);
		printf("b=%x\n",&b);
		printf("c=%x\n",&c);
		printf("d=%x\n",&d);
		printf("e=%x\n",&e);
		printf("f=%x\n",&f);
		printf("p1=%x\n",p1);
		printf("p2=%d\n",p2);
		printf("add=%x\n",add);
		printf("main=%x\n",main);


		printf("%d\n",getpid());
		while(1);
}
