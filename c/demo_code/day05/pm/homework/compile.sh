gcc -fpic -shared fileop.c -olibku.so
gcc main.c -L. -lku -omain
