#!/bin/bash

:<<comment
   - >&n 使用系统调用dup(2)复制文件描述符n并把结果用作标准输出，man 2 dup了解dup
   - <&n 标准输入复制自文件描述符n
   - <&- 关闭标准输入
   - >&- 关闭标准输出;
   - n<&- 表示将n号输入关闭;
   - n>&- 表示将n号输出关闭;
   - exec 1>outfilename # 打开文件outfilename作为stdout。
   - exec 2>errfilename # 打开文件errfilename作为 stderr。
   - exec 0<&- # 关闭 标准输入
   - exec 1>&- # 关闭 标准输出
   - exec 2>&- # 关闭 错误输出
   - exec 8>&- # 关闭 8号描述符(输出)
comment

# 打开文件, 向文件写与读
# 文件描述符3重定向到/tmp/k1
# 文件描述符4从/tmp/k1读取数据
exec 3>/tmp/k1
exec 4</tmp/k1

# 通过3写到/tmp/k1
cat <<EOF 1>&3
a
b
c
EOF

# 通过4读取/tmp/k1
cat <&4
