#!/bin/bash
:<<comment
1.sort常用参数
    -n : 按照数字排序(numerically)
    -d : 字典排序(dictionary) 默认排序
    -r : 倒排序(reversely)  默认升序排序
    -k N1,N2 : 按哪几个字段排序(keywords), 字段序号是1,2..
    -f : 忽略大小写
    -u : 去掉重复数据
    -t : 设定分隔符
comment

# 数字排序倒排按第三个字段, 再去重
#cat file.txt | sort -nr -k2 | uniq 
cat seq.txt | sort -nr -k2 | uniq 

# 字典排序倒排按第三个字段, 再去重
cat file.txt | sort -dr -k2 | uniq 

# 数字排序正排按第二个字段
cat facebook.txt | sort -n -k 2 -t: 

# 按公司名字的字母顺序排序，按第一个域进行排序
sort -t' ' -k 1 facebook2.txt

# 按公司人数排序，按第二个域进行排序
sort -n -t' ' -k 2 facebook2.txt

# 按公司人数排序，人数相同的按照员工平均工资升序排序
sort -n -t' ' -k 2 -k 3 facebook2.txt

# 按照员工工资降序排序，如果员工人数相同的，则按照公司人数升序排序
sort -n -t ' ' -k 3r -k 2 facebook2.txt


:<<comment
2.uniq常用参数
    -c : 在行首统计出现的次数
    -d : 打印挨着的重复的行数据 
    -u : 打印不重复的行数据
comment
