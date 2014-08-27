#!/bin/bash

echo "begin compiling objective files..."
echo "gcc -c -fpic input.c"
echo "gcc -c -fpic print.c"
gcc -c -fpic input.c
gcc -c -fpic print.c

echo "linking the shared objective files..."
echo "gcc input.o print.o -shared -olibku.so"
gcc input.o print.o -shared -olibku.so

echo "building the objective file..."
echo " gcc main.c -lku -L. -o main"
gcc main.c -lku -L. -o main

