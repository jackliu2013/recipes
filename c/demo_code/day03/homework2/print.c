#include <stdio.h>
#include <math.h>

/* 打印菱形 
* 参数：r -- 菱形边长
*/
void print_rhombus()
{
	int i,j;
	int r = 6;
	for(i=-r;i<=r;i++)
	{
		for(j=-r;j<=r;j++)
		{
			if( (abs(i) + abs(j)) == r)	
					printf("*");
			else
					printf(" ");
		}
		printf("\n");
	}
}

/* 打印乘法表 
*
*/
void print_cf()
{
	int i,j;
	for(i=1;i<=9;i++)
	{
		for(j=1;j<=i;j++)
		{
			printf("%d*%d=%d\t",i,j,i*j);
		}
		printf("\n");
	}

}
