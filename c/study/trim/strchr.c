#include <string.h>
#include <stdio.h>
#include <unistd.h>

/*
    函数原型:char * strchr (const char *s,int c);
    函数说明:strchr()用来找出参数 s 字符串中第一个出现的参数 c 地址,然后将该字符出现的地址返回。
    返 回 值:如果找到指定的字符则返回该字符所在地址,否则返回 0

*/

main()
{
    char *s = "123456789";
    char *p;

    // 找出字符串的结尾
    p=strchr(s,0);

    //p--;

    printf("%s\n", p);

    // 打印出地址
    // printf("%x\n", p);


    char *q = "10000.01";
    p = strchr(q, '.');

    if(strlen(p) != 3) {
        printf("format error\n");
        return;
    }
    
    printf("%s\n", p);
    printf("%d\n", strlen(p));
    
}

