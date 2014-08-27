#!/bin/bash

#
#  重复制造流水
#  把一个流水文件中的数据复制1000次
#

#
# 传递两个参数
#   1. -f
#   2. filename 
#
if [ $# != 2 ]  
then
   echo "usage ./repeat.sh -f filename"
   exit 1
fi

#
# 把流水中的文件复制1000次，并且重定向到一个新的文件
#
file=$2;
for i in `seq 1 1000`
do
    cat $file >> "$file.tmp"
done
