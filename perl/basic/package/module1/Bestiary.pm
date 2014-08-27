#一个模块可以有两个方法把它的接口提供给你的程序使用:
#把符号输出或者允许方法调用。我们在这里先给你演示一个第一种风格的例子;
# 构造一个叫 Bestiary 的模块,创建一个看着象下面这样的叫 Bestiary.pm 的文件

#!/usr/bin/perl

package Bestiary;

require Exporter;
our @ISA    = qw/Exporter/;
our @EXPORT = qw/camel/;      # 缺省输出的符号

our @EXPORT_OK = qw/$weight/; # 按要求输出的符号
our $VERSION   = 1.00;        # 版本号
### 在这里包含你的变量和函数
sub camel {
    print "One-hump dromedary";
}

$weight = 1024;


1;
