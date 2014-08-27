/* memseg.c  memorysegment.c */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


main()
{
	int a1=10;
	int a2=10;
	int a3=10;
	int a4=10;
	
	int *p1=malloc(4);
	int *p2=malloc(4);
	int *p3=malloc(4);
	int *p4=malloc(4);
	

	printf("%x\n",&a1);
	printf("%x\n",&a2);
	printf("%x\n",&a3);
	printf("%x\n",&a4);


	printf("%x\n",p1);
	printf("%x\n",p2);
	printf("%x\n",p3);
	printf("%x\n",p4);

		
}
