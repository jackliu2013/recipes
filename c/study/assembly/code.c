#include <stdio.h>

int accum = 0;

int sum(int x, int y) 
{
	int t = x + y;
	accum += t;
	return t;
}

void main() 
{
	printf("%d\n", sum(10,10));	
	
}
