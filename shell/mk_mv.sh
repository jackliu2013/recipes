# 判断以当前日期命名的目录名时候存在 如果存在把所有文件移动到该目录
# 如果目录不存在，则创建该目录，然后把所有文件移动到该目录


#!/bin/bash

today=`date +%Y%m%d`
echo $today

if [ -d $today ]
then
	mv * $today
else
	mkdir $today
	mv * $today
fi
