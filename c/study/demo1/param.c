#include <stdio.h>
#include <stdlib.h>

int compare(int *a, int *b)
{
    if (*a >= *b) {
        return 1;
    }
    else {
        return 0;
    }
}

int main(int argc, char **argv) {
    int a, b;
    a = 10;
    b = 9;
    int c = compare(&a, &b); 
    printf("c is %d\n", c);
    return 0;
}
