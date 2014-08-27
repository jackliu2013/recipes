#include <string.h>
#include <stdio.h>

#define ARR_LEN (20)

main()
{
    char s[]="120214240|2013-12-22|10000609151|10012126282|31|900.00|1.17|0.00|0.00";
    char *ret[ARR_LEN];
    char *delim="|";
    int i = 0;
    int j = 0;
    char *p = strtok(s, delim);
    printf("%s\n", p);
    ret[i] = p;

    while(p=strtok(NULL,delim)) {
        i++;
        ret[i] = p;
        //printf("%s ",p);
    }
    printf("\n");
    printf("fileds:%d\n", i+1);
    while(j <= i) {
        printf("%s\n", ret[j]);
        j++;
    }
}

