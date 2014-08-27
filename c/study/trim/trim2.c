#include <stdio.h>
#include <string.h>

#define STR_LEN (200)

/*
* 输入参数 s
* 函数功能: 去除字符串s两边的空格
*
*/
char *tr ( char *s )  
{  
   int i = 0;  
   int j = strlen ( s ) - 1;  
   int k = 0;  
    
   while ( isspace ( s[i] ) && s[i] != '\0' )  
     i++;  
    
   while ( isspace ( s[j] ) && j >= 0 )  
     j--;  
    
   while ( i <= j )  
     s[k++] = s[i++];  
    
   s[k] = '\0';  
    
   return s;  
}  

int main(int argc, char **argv)
{
    char s[STR_LEN];
    memset(s, 0, sizeof(s));
    strcpy(s, " hello, this is test!   "); 
    printf("before trim [%s]\n", s);
    tr(s);
    printf("after trim [%s]\n", s);
    return 0;
}
