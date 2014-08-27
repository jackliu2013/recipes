#把print.c中的函数封装成动态库来调用
gcc -shared -fpic print.c -olibdlku.so
gcc main.c -ldlku -L. -omainso
