#!/bin/bash
# 统计每个单词的个数，并从小到大排序
if [ $# -lt 1 ]
then
	echo "请输入要统计的文件名";
else
#	echo "正在统计中......";
	cat $1| sed -e "s/[^a-zA-Z]/\n/g"|grep -v ^$|sort|uniq -c|sort -n -r	
fi

