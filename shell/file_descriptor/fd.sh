#!/bin/bash

:<<comment
1. 三个预留的文件描述符
   1. 标准输入(stdin)   0   默认是键盘
   2. 标准输出(stdout)  1   默认是屏幕
   3. 标准出错(stderr)  2   默认是屏幕
comment

# 标准输出重定向 方式1
echo "--------------T1--------------";
echo "test1" > /tmp/t1
cat /tmp/t1

# 标准输出重定向 方式2
echo "--------------T2--------------";
echo "test2" 1>/tmp/t2
cat /tmp/t2

# 标准出错重定向
echo "--------------T3--------------";
echo "not exist cmd" 2>/tmp/t3
cat /tmp/t3

# 标准输出,出错都重定向
echo "--------------T4--------------";
(echo "test4"; "我输入的不存在的命令";) >/tmp/t4 2>&1
cat /tmp/t4

# 标准出错都重定向到/dev/null
echo "--------------T5--------------";
(echo "test5"; "我输入的不存在的命令";) >/tmp/t5 2>/dev/null
cat /tmp/t5
