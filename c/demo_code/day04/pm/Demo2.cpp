#include <cstdio>
#include <cstdlib>
#include <new>

main()
{
	int a[20][20]={10};
	printf("%d\n",a[10] - a[1]);

	int *p[20];
	p[0]= a[0];
	p[1]= a[1];
	p[2]= a[2];
	p[3]= a[3];
	p[4]= a[4];
	p[5]= a[5];
	p[6]= a[6];
	p[7]= a[7];
	p[8]= a[8];
	p[9]= a[9];
	p[10]= a[10];
	p[11]= a[11];
	p[12]= a[12];
	p[13]= a[13];
	p[14]= a[14];
	p[15]= a[15];
	p[16]= a[16];
	p[17]= a[17];
	p[18]= a[18];
	p[19]= a[19];

	printf("%x\n%x\n",a[1],a[10]);
	printf("%d\n",p[10]-p[1]);

}
