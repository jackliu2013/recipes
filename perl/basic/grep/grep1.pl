#从一个大的数字列表中得到其中的奇数。这里不需要使用什么新的方法:

#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;

## 把奇数存放在@odd_numbers的数组中
#my @odd_numbers;
#foreach ( 1 .. 10 ) {
#    push @odd_numbers, $_, if $_ % 2;
#}

## grep 第一个参数是一个块,其中$_依次为列表中的每一个值,返回
## 一个 Boolean(true/false)值。剩下的参数是相应的列表。grep 会首先计算表达式的值,这和 foreach 循环一致。如果块中最后
## 一个表达式的返回值为 true,则这个元素会被返回。
my @odd_numbers = grep { $_ % 2 } 1 .. 10;

## 打印@odd_numbers数组中的元素
Data::Dump->dump(\@odd_numbers);
Data::Dump->dump(@odd_numbers);
