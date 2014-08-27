#include <stdio.h>

int *sum(int a, int b)
{
   int c = a + b ;
   return &c;
}

int multi(int c, int d)
{
    return (c * d);
}

int main(int argc, char ** argv)
{
    // *p 整形指针
    int *p=NULL;
    int a = 1;
    p = &a;
    *p = 10;
    printf("%d\n",*p);


    int b[3] = {1, 2, 3};
    printf("%d\t%d\t%d\n", b[0], b[1], b[2]);
    printf("%d\t%d\t%d\n", *b, *(b+1), *(b+2));


    // 定义指针数组  q[3] 是一个整形指针数组，数组的每个元素是一个整形指针，每个指针指向的是一个整数
    int *q[3];
    q[0] = &b[0];
    q[1] = &b[1];
    q[2] = &b[2];
    printf("access by 指针数组：%d\t%d\t%d\n", *(q[0]), *(q[1]), *(q[2]));

    // 定义数组指针 r是一个指针，指向的是一个3个整形元素的数组
    int (*r)[3] = NULL;
    r = b;
    // 访问数组的第0个元素
    printf("%d\n", (*r)[0]);
    // 访问数组的第1个元素
    printf("%d\n", (*r)[1]);

    char str[2][20] = { "hello world", "welocme" };
    printf("通过数组名来访问数组：\n");
    printf("%s\n", str[0]);
    printf("%s\n", str[1]);

    printf("通过数组指针来访问数组：\n");
    char (*m)[20] = NULL;
    m = str[0];
    printf("%s\n", m);
    m = str[1];
    printf("%s\n", m);


    int *w = sum(4,5);
    printf("函数指针: %d\n", *w);

    
    // 函数指针来访问函数
    int (*s)(int,int) = multi(5,5);
    printf("通过函数指针访问函数，并得到返回结果:%d\n",*s);
    
    return 0;
}
