#!/bin/bash

<<comment
1.文件状态测试
	-d  目录
	-f  正规文件
	-L  符号连接
	-r  可读
	-s  文件长度大于 0、非空
	-w  可写
	-u  文件有suid位设置
	-x  可执行
测试文件状态一般两种格式
    1. test condition
    2. [ condition ]    使用方括号时，注意在条件两边加上空格
comment

if [ -x for.sh ]; then
    echo "for.sh 可执行";
else
    echo "for.sh 不可执行";
fi

# -a 逻辑与,操作符两边均为真，结果为真，否则为假
# -o 逻辑或,操作符两边一边为真，结果为真，否则为假
if [ -x for.sh -a -x while.sh ]; then
    echo "for.sh and while.sh 都可执行";
else
    echo "for.sh, while.sh 至少一个不可执行";
fi

<<comment
2.字符串测试
    =       两个字符串相等
    !=      两个字符串不等
    -z      空串
    -n      非空串
字符串测试有5种格式：
    1.  test "string"
    2.  test string_operator "string"
    3.  test "string" string_operator "string"
    4. [ string_operator string ]
    5. [ string string_operator string ]
comment
#stra="";
stra=" ";
strb="hello";
strc="hello world";
echo "$stra";
echo "$strb";
echo "$strc";

if [ -z "$stra" ]; then
    echo "stra 是空串";
else
    echo "stra is $stra";
fi

if [ "$stra" != "$strb" ]
then
    echo "stra isn't equal to strb";
else
    echo "stra is equal to strb";
fi

if [ "$stra" = "$strc" ]
then
    echo "stra is equal to strc";
else
    echo "stra isn't equal to strc";
fi


<<comment
3.测试数值
    -eq     数值相等
    -ne     数值不相等
    -gt     第一个大于等于第二个数
    -lt     第一个数小于第二个数
    -le     第一个数小于等于第二个数
    -ge     第一个数大于等于第二个数
测试数值的格式：
    1."number" numeric_operator "number"
    2. [ "number" numeric_operator "number" ]
comment

num1=10;
num2=9
num3=10;
num4=12;

echo "num1=$num1, num2=$num2 ,num3=$num3, num4=$num4";
if [ "$num1" -eq "$num3" ]; then
    echo "num1 is equal to num3";
else
    echo "num1 isn't equal to num3"
fi

if [ "$num1" -gt "$num2" ]; then
    echo "num1 is great than num2";
else
    echo "num1 is not great than num2";
fi

if [ "$num1" -lt "$num4" ]; then
    echo "num1 is less than num4";
else
    echo "num1 is not less than num4";
fi
