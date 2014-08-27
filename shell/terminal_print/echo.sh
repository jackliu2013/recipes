#!/bin/bash

:<<comment
echo 命令
    1.-e 包含转义序列的字符串
    2.颜色输出
        
comment

echo -e "hello\tworld";
# 颜色输出
echo -e "\e[1;31m";     # 红色
echo -e "\e[1;30m";     # 黑色
echo -e "\e[1;40m";     # 黑色
echo -e "\e[1;41m";     # 黑色
echo -e "\e[1;42m";     # 黑色
echo -e "\e[1;43m";     # 黄色
echo -e "\e[1;44m";     # 蓝色
echo -e "\e[1;45m";     # 洋色
echo -e "\e[1;46m";     # 青色
echo -e "\e[1;47m";     # 白色
echo -e "\e[0;m";       # 颜色置回

