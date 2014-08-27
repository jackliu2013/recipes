#include <stdio.h>
#include <stdlib.h>

#define TYPE struct stu
#define LEN sizeof (struct stu)
struct stu
{
    int num;
    int age;
    struct stu *next;
};

TYPE *creat(int n)
{
    struct stu *head,*pf,*pb;
    int i;
    for(i=0;i<n;i++)
    {
        pb=(TYPE*)malloc(LEN);
        printf("input Number and Age\n");
        scanf("%d %d",&pb->num,&pb->age);
        if(i==0)
            pf=head=pb;
        else 
            pf->next=pb;
        pb->next=NULL;
        pf=pb;
    }
    return(head);
}

int main(int argc, char **argv) 
{
    int num = 2;
    TYPE *p = NULL;
    p = creat(num);
    while(p)
    {
        printf("num:%d\t age:%d\n", p->num, p->age);
        p = p->next;
    }
    return 0;
}
