#通过调用/lib/libdl.so的dlopen,dlsym,dlclose来调用动态库libdlku.so中的函数
gcc main2.c -ldl  -omain2
