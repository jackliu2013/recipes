#!/bin/bash

#   归档

# 1.tar文件归档
# 参数
# -c  : create
# -f  : filename
#
tar -cf dst.tar src1 src2 .. srcN

# 2.向归档文件中添加文件
#
# -r  : 追加
# -v  : verbose
# -u  : update
#
tar -rvf original.tar new_file
tar -uvvf original.tar filea  # 只有filea时间戳有更新才更新original.tar

# 3.查看归档文件列表

tar -tvf  original.tar
tar -tvvf original.tar  # 更加详细

# 4.提取文件

tar -xvf orginal.tar

# 5.tar中使用stdin, stdout

# -f指定stdout (-c)
# -f制定stdin  (-x)
# -C : 改变到某个目录
tar -cf - file1 file2 file3 | tar -xvf - -C dst

# 6.拼接归档文件

tar -Af dst.tar appended.tar

# 7.比较归档文件中的文件差异

tar -df archive.tar file1 file2

# 8.从归档文件中删除
tar -f archive.tar --delete file1 file2


