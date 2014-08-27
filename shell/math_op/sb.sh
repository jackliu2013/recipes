#!/bin/bash

:<<comment
[], (())与数学运算
comment

a=1
b=2

c=$[ 1 + 2 ] # c = 3
echo "c = $c";

d=$[ a + b * c ]  # d = 7
echo "d = $d";

d=$[$a+$b*$c]  # d = 7
echo "d = $d";

d=$((a+b*c));  # d = 7
echo "d = $d";

((d=a+b*c*100));  # d = 1 + 2*3*100 = 601
echo "d = $d";
