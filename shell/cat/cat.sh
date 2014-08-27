#!/bin/bash

# 1.将文件的内容输出到标准输出
cat file1 file2

# 2.将标准输出与文件拼接
# '-' 一般作为stdin/stdout的文件名称
#echo "text through stdin" | cat - file.txt

# 3.压缩空白行: -s
cat -ns file.txt

# 4.将制表符显示为^I: -t
#cat -t file.txt

# 5.显示行号: -n 空白行的行号也显示 -b空白行的行号不显示
#cat -n file.txt
#cat -b file.txt
