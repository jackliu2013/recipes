#!/usr/bin/env perl

=comment

实现绑定一个数组，这个数组的范围在创建的时候是固定的
如果试图访问任何超出该界限的东西，将抛出一个异常。

=cut

use BoundedArray;

# 最大的索引是2
tie @array, "BoundedArray", 2;

$array[0] = 'fine';
$array[1] = 'good';
$array[2] = 'great';
$array[3] = 'whoa';     # 禁止，显示一个错误消息
