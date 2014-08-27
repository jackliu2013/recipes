#!/bin/bash

<<comment
1.变量替换
   掐头去尾--记忆方式
    #   去掉头部
    %   去掉尾部
    单一符号是最小匹配
    连个符号是最大匹配 
comment

file="/dir1/dir2/dir3/my.file.txt";
echo "${file#*/}";     # 去掉file的头部直到遇到第一个'/',结果为dir1/dir2/dir3/my.file.txt

echo "${file##*/}";     # 去掉file的头部直到遇到最后一个'/', 结果为my.file.txt

echo "${file#*.}";      # 去掉file的头部直到遇到第一个'.',结果为file.txt

echo "${file##*.}";     # 去掉file的头部直到遇到最后一个'.',结果为txt

echo "${file%/*}";      # 去掉file的尾部直到遇到第一个'/',结果为/dir1/dir2/dir3

echo "${file%%/*}";     # 去掉file的尾部直到遇到最后一个'/',结果为''

echo "${file%.*}";      # 去掉file的尾部直到遇到'.',结果为/dir1/dir2/dir3/my.file

echo "${file%%.*}";     # 去掉file的尾部直到遇到最后一个'.',结果为/dir1/dir2/dir3/my
                      
<<comment
2.字串提取
    ${file:0:5} 提取最左边的5个字节：/dir1
    ${file:3}   去掉前面3个字符
    ${file:5:5} 提取第5个字节右边的连续的5个字节：/dir2
comment

printf "===============================\n";
file="/dir1/dir2/dir3/my.file.txt";
echo "${file:0:5}";        # 结果为/dir1
echo "${file:3}";       # 结果为r1/dir2/dir3/my.file.txt
echo "${file:5:5}";     # /dir2


<<comment
3.字符串替换
    ${file/dir/path}    把第一个dir替换为path, 结果为/path1/dir2/dir3/my.file.txt
    ${file//dir/path}   把所有的dir替换为path, 结果为/path1/path2/path3/my.file.txt
comment
    echo "${file/dir/path}";
    echo "${file//dir/path}";


<<comment
4.通用变量名
   ${!prefix*}  代表所有以prefix开始的变量名,各变量名称之间以空格符分隔 
comment
ab=1;
abc=2;
abcd=3;
echo ${!ab*};   # 输出ab abc abcd


<<comment
5.变量赋值
${#myvar} : 计算出变量值的长度
${myvar=default} : 若$myvar 没设定，则输出并取值 default。(保留空值及非空值)
${myvar:=default} : 若$myvar 没设定或为空值，则输出并取值 default。(保留非空值)
${myvar+default} : 若$myvar 设定为空值或非空值，输出但不取值 default，否则返回空(null)。
${myvar:+default} : 若$myvar 设定为非空值，输出但不取值 default，否则返回空(null)。
${myvar-default} : 若$myvar 没设定，输出但不取值 default。(保留空值及非空值)
${myvar:-default} : 若$myvar 没设定或为空值，输出但不取值 default。(保留非空值)
${myvar?default} : 若$myvar 没设定，将 default 输出至 STDERR。(不取值，保留空值及非空值)
${myvar:?default} : 若$myvar 没设定或为空值，将 default 输出至STDERR。(不取值，保留非空值
comment
