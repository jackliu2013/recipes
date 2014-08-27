#!/usr/bin/env perl

use strict;
use warnings;

package Some::Module;
sub bar { print "I'm in " . __PACKAGE__ . "\n\n"}


package main;

# 调用 Some::Module里的bar 函数
Some::Module::bar();

# 重定义Some::Module下的bar函数
# 用一个匿名子程序替换了Some::Module包的一个具名子程序的定义
#
no warnings 'redefine'; # 关闭重定义的警告
*Some::Module::bar = sub { print "Now I'm in " . __PACKAGE__ . "\n\n" };

# 再次调用Some::Module下的bar函数
Some::Module::bar();
