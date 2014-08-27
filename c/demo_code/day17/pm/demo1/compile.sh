#!/bin/bash
# 编译C++头文件
#g++ -c userdata.h
#g++ -c mythread.h

# 编译C++代码文件
g++ -c userdata.cpp 
g++ -c mythread.cpp 
g++ -c data_main.cpp 

g++ userdata.o mythread.o data_main.o -omain -lpthread
