#!/bin/bash

<<comment
变量替换
comment


file="yspz0019.sql"
# 把文件名,及文件名的后缀分开
echo "filename:${file%.*}"
echo "extension:${file##*.}"

file="0043_test.dat"

echo "filename:${file%_*}"
