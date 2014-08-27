#include <stdio.h>

int main()
{
	int m;
	void (*p) ();
	do
	{
		printf("请输入选项：\n");
		printf("1.打印菱形\n");
		printf("2.打印乘法表\n");
		printf("3.退出\n");
		scanf("%d",&m);
		printf("%d\n",m);
		if( m>3 || m<0)
		{
			printf("输入不合法，请重新输入\n");
		}
	}while( m>4 || m <0);
		if( m ==1)
			p=print_rhombus();
		else if (m==2)
			p=print_cf();
		else if (m == 3)
			exit(0);
	return 0;
}
