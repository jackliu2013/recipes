#!/usr/bin/env perl

use strict;
use warnings;

# fileglob 和 typeglob 都把*字符用于通配符模式以外，当用作通配符用途时
# 字符*是glob的别名
#
# 对于fileglob而言，它是在一个目录里做通配符匹配，像各种shell做的一样
# 对于typeglob而言，它是glob符号表里相同名字的符号
#

# 打印所有的以.pl结尾的文件
while (<*.pl>) {
    print "$_\n";
}
