#把print.c中的函数封装成静态库来调用
gcc -c -fpic  print.c
ar rv libku.a print.o
gcc main.c -fpic -lku -L. -omain
