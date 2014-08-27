#!/bin/bash

:<<comment
1.根据文件名,路径,正则搜索
comment
# 查找所有txt文件 在当前用户home目录
find ~ -name "*.txt" -print

# 查找所有txt与pdf文件
find ~ -name \( -name "*.txt" -o -name "*.pdf" \) -print

# 查找路径中有haryzhou的文件
find ~ -path "*haryzhou*" -print

# 通过-iregex查找: python与shell程序文件
find . -iregex ".*\(\.py\|\.sh\)$" 

:<<comment
2. 否定参数
comment
# 查找所有非txt文件
find . ! -name "*.txt" -print

:<<comment
3. 其他常用参数
   1. `-maxdepth`  : 制定搜索的最大深度
   2. `-type`      : 文件类型: f, d, l, c, b, s, p
   3. `-atime -mtime -ctime` : 时间相关
   4. `-size`      : 文件大小: +2k(大于) -2k(小于) 2k(等于) 其他单位(M,G)
   5. `-user`      : 用户
comment

:<<comment
3. `-print`的替代参数

   1. '-delete' : 将找到的文件删除
   2. '-exec cmd {} \;'   : 将找到文件实施cmd操作, {}是相应的文件名称
comment

find . -type f -user root -exec chown slynux {} \;
find . -type f -name "*.c" -exec cat {} \; > all_c_files.txt
find . -mtime +10 -name "*.txt" -exec cp {} /tmp/old \;
