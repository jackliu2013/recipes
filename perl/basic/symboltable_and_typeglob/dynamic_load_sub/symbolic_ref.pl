#!/usr/bin/env perl

=comment
1.首先，把名字foo保存在标量$good_name中

2.然后，把$good_name当成typeglob的引用，对它进行反引用，这样就可以把一个匿名子程序赋给它(对$href反引用是%{$href}, 对$aref反引用是@$aref,对typeglob类型团反引用是*{$type_ref})

3.由于$good_name不是一个引用，perl会把它的值当作一个符号引用处理，它的值变成了perl要检查和修改的typeglob的名字，当我们把匿名子程序传给*{$good_name}时，perl会在当前软件包的符号表里为名字是&foo的子程序创建一个项目，这种方式也适用于完整的软件包表示方法,所以我们也可以创建如&Some::Module::foo的子程序

=cut

use strict;

no strict 'refs';


# 在当前包里创建名字为foo的子程序
my $good_name = "foo";  # $good_name 当作符号表的引用

# 对$good_name 进行发引用，同时给反引用后的typeglob赋值
* { $good_name } = sub { print "Hi, how are you?\n" };

# 在Some::Module包里创建名字为foo的子程序
my $remote_name = "Some::Module::foo";
* { $remote_name } = sub { print "Hi, are you from Main?\n" };

foo();                  # no problem
Some::Module::foo();    # no problem
