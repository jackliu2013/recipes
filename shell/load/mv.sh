#!/bin/bash

#
# shell 编程的参数替换
#

file="F0061.src.tmp"
echo "filename:${file%.*}"
echo "extension:${file##*.}"

