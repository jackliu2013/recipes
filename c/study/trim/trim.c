#include <stdio.h>
#include <string.h>

int IsSpace(int);       /* 0 - 255 的整数和char 字符相互转换 */

char *LTrim(char *s);     /* 去掉字符串s的左边的空格 \n \t */
char *RTrim(char *s);     /* 去掉字符串s的右边的空格 \n \t */
char *Trim(char *s);      /* 去掉字符串s左右两边的空字符 */

int main(int argc, char **argv)
{
    char str[] = "   hello world   ";

    /*
    int len = strlen("hello");
    printf("str len is %d\n", len);
    */

    // LTrim(str);
    // printf("LTrim: [%s]\n", str);

    // RTrim(str);
    // printf("RTrim: [%s]\n", str);
    Trim(str);
    printf("Trim: [%s]\n", str);

    return 0;
}

int IsSpace(int c) 
{
    return c==' ' || c=='\n' || c=='\t';
}

char *LTrim(char *s)
{
   char *p=NULL;
   for (p=s;IsSpace(*p);p++);
   while(*p)
   {
       *(s++) = *(p++); 
   }
   *s=0;
   return s;
}

char *RTrim(char *s)
{
   char *p;
   for (p=strchr(s,0); p>s && IsSpace(*(p-1)); p--);
   *p=0;
   return s;
}

char *Trim(char *s)
{
   LTrim(s);
   RTrim(s);
   return s;
}
