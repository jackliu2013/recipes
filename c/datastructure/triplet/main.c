#include <stdio.h>
#include <stdlib.h>

#include "triplet.h"

int main(int argc, char **argv)
{
    /*
    int *p =(int *)malloc(3*sizeof(int));
    if(!p) {
        printf("malloc error\n");
        return 0; 
    }
    p[0] = 1;
    p[1] = 2;
    p[2] = 3;

    printf("%d\t%d\t%d\n", p[0], p[1], p[2]);
    free(p); 
    */

    int *T;
    int a = 10;
    int b = 11;
    int c = 12;
    if (!InitTriplet(&T, a, b, c)) {
        printf("InitTriplet error\n");
        return 0;
    }
    printf("%d\t%d\t%d\n", T[0], T[1], T[2]);
    
    int tmp;
    int i = Get(T, 2, &tmp);
    if(i==OK)
        printf("T的第2个值为：%d\n",tmp);

    i=Put(T,2,6);
    if(i==OK)
        printf("将T的第2个值改为6后，T的三个值为：%d %d %d\n",T[0],T[1],T[2]);

   i=IsAscending(T); /* 此类函数实参与ElemType的类型无关,当ElemType的类型变化时,实参不需改变 */
   printf("调用测试升序的函数后，i=%d(0:否 1:是)\n",i);

   i=IsDescending(T);
   printf("调用测试降序的函数后，i=%d(0:否 1:是)\n",i);

   if((i=Max(T,&tmp))==OK) /* 先赋值再比较 */
     printf("T中的最大值为：%d\n",tmp);

   if((i=Min(T,&tmp))==OK)
     printf("T中的最小值为：%d\n",tmp);

    DestroyTriplet(&T);    
    return 0;
}
