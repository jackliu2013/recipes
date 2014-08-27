#!/bin/bash

:<<comment
常用参数
    - 'c' :  print the byte counts
    - 'm' :  print the character counts
    - 'l' :  print the newline counts
    - 'w' :  print the word counts
comment

# 统计字节数
printf "统计字节数\n"
cat count_aa | wc -c

# 统计字符数
printf "统计字符数\n"
cat count_aa | wc -m

# 统计行数
printf "统计行数\n"
cat count_aa | wc -l

# 统计单词数
printf "统计单词数\n"
cat count_aa | wc -w
