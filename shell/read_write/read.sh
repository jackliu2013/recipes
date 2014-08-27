#!bin/bash

<<comment
read 语句从键盘或文件读入数据，并将其赋值给一个变量。
如果只指定了一个变量，read会把所有的输入赋值给该变量，
直到读入第一个文件结束符或回车
comment

printf "%d\n" 1;
# 从文件依次读取行数据
while read v
do
    echo "got line data[$v]";
#done < r_t.dat
done < r_t2.dat


printf "=========================\n";


printf "%d\n" 2;
# 利用管道
cat r_t.dat |
while read v; do
    echo "got line data[$v]";
done
