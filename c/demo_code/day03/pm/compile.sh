#!/bin/bash
echo "compiling the objective files..."
gcc -c -fpic input.c
gcc -c -fpic diamond.c


echo "lingking the shared file..."
gcc input.o diamond.o -shared -olibku.so

echo "called the shared file..."
gcc main.c -lku -L. -omain
