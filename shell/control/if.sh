#!/bin/bash

<<comment
if else流控制结构
comment

num1=10;
num2=12;
num3=10;
num4=11;

echo "num1=$num1 , num1=$num2 , num1=$num2 , num1=$num3";

if [ $num1 -gt $num2 ]
then
    echo "num1 > num2";
elif [ $num1 -eq $num2 ]
then
    echo "num1 = num2";
elif [ "$num1" -lt "$num2" ]
then
    echo "num1 < num2";
fi
