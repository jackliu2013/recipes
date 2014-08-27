#!/bin/bash

:<<comment
1.tr主要功能
tr用来从标准输入中通过替换或删除操作进行字符转换。 tr主要用于删除文件中控制字
符或进行字符转换。使用tr时要转换两个字符串:字符串1用于查询,字符串2用于处理各
种转换。tr刚执行时,字符串 1中的字符被映射到字符串 2中的字符,然后转换操作开始。

2.常用命令及参数
tr[-c|-d|-s]["string1_to_translate_from"]["string2_to_translate_to"] Input-file

    -c 用字符串1中字符集的补集替换此字符集,要求字符集为 ASCII。
    -d 删除字符串 1中所有输入字符。
    -s 删除所有重复出现字符序列,只保留第一个;即将重复出现字符串压缩为一个
       字符串。
    Input-file是转换文件名。虽然可以使用其他格式输入,但这种格式最常用。

3.字符范围
使用tr时,可以指定字符串列表或范围作为形成字符串的模式。这看起来很像正则表达式,
但实际上不是。指定字符串 1或字符串2的内容时,只能使用单字符或字符串范围或列表。
    [a-z]  : a-z内的字符组成的字符串。
    [A-Z]  : A-Z内的字符组成的字符串。
    [0-9]  : 数字串。
    /octal : 一个三位的八进制数,对应有效的 ASCII字符。
    [O*n]  : 表示字符O重复出现指定次数 n。因此[O*2]匹配OO的字符串。

4.tr中控制字符不同表达方式
速记符含义      含义            八进制方式
\a             Ctrl-G 铃声      \007
\b             Ctrl-H 退格符    \010
\f             Ctrl-L 走行换页  \014
\n             Ctrl-J 新行      \012
\r             Ctrl-M 回车      \015
\t             Ctrl-I tab键     \011
\v             Ctrl-X           \030

comment

# 删除oops.txt中重复的[a-z]字符
tr -s "[a-z]" < oops.txt >result.txt

# 删除空行
tr -s "[\012]" <plane.txt >result_2.txt

# 小写到大写
echo "May Day, May Day, Going Down.." | tr "[a-z]" "[A-Z]"

# 用字符类 实现小写到大写的转换
echo "May Day, May Day, Going Down.." | tr "[:lower:]" "[:upper:]"  

# 大写到小写
echo "May Day, May Day, Going Down.." | tr "[A-Z]" "[a-z]"
echo "May Day, May Day, Going Down.." | tr "[:upper:]" "[:lower:]"  

# 删除指定字符 将文件每行所有不包含在[a-z]和[A-Z]的字符串放在字符串1中
# 并转换为一新行 -s选项表明压缩所有新行 -c表明保留所有字母不动
tr -cs "[a-z][A-Z]" "[\012*]" < diary.txt

# 转换控制字符 cat -v 文件显示控制字符 
