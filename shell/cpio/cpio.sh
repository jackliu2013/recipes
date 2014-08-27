#!/bin/bash

# cpio通过stdin获取文件名, 并将归档文件写入stdout

#touch file1 file2 file3

# -o 指定了输出
# -v 打印归档列表
cat file1 file2 file3 | cpio -ov > archive.cpio

# 列出归档内容
# -i 制定输入
# -t tabulate
cpio -it < archive.cpio

# 提取文件
cpio -id < archive.cpio
