#!/bin/bash

#
# 把所有的F*.src文件中的数据复制1000次，并且新的数据重定向到临时
# 文件里，然后在把所有的临时文件mv成原来的文件名 
#


for file in `ls F*.src`
do 
   # echo $file; 
   # ./repeat.sh -f $file;
   for i in `seq 1 1000`
    do
        cat $file >> "$file.tmp"
    done
done


for nfile in `ls F*.tmp`
do
    mv $nfile ${nfile%.*}
done
