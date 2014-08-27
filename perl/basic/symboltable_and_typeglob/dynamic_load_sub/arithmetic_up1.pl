#!/usr/bin/env perl

#
# 把子程序(函数)当作数据使用
#

#
# 对basic-arthimetic.pl 的 升级,根据输入找到合适的子程序，在这个demo里
# 我们建立一个分配表(一个保存所有匿名子程序的哈希表),然后通过键值选择
# 合适的子程序，在此demo里，我们使用操作符作为键值，同时，我们也可以
# 捕获错误的输入，因为我们知道哪写操作符是合法的--合法的操作符一定是
# 哈希表的键
#

use strict;

# 声明全局变量
use vars qw/%operators/;

%operators = (
    '+' => sub { $_[0] + $_[1] },
    '-' => sub { $_[0] - $_[1] },
    '*' => sub { $_[0] * $_[1] },
    '/' => sub { $_[1] ? eval { $_[0] / $_[1] } : 'NaN' },
    );

while(1) {
    my ( $operator, @operand ) = get_line();

    my $some_sub = $operators{$operator};

    unless ( $some_sub ) {
        print "No such operator { $operator }!\n";
        last;
    }

    print $operators{$operator}->(@operand);
}

print "Done, exiting...\n";

sub get_line {

    # 我们可以把它变得更复杂一些，但是它不是我们关心的重点
    print "\nprompt> ";

    my $line = <STDIN>;

    # 去除行首行位空格
    $line =~ s/^\s+|\s+$//g;

    # 以一个或多个空格拆分输入，返回一个输入的列表,列表是 操作符号 操作数1 操作数2
    ( split /\s+/, $line )[1, 0, 2]; 
}
