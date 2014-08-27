#!/usr/bin/env perl

#
# 通过把一个typeglob赋值给另一个typeglob，我们可以创建变量的别名
# 下面把*foo typeglob赋值给*bar typeglob后，所有标志符为bar的变量
# 都变成了标志符为foo的变量的别名。当我们改变变量bar或foo的时候，
# 另一个变量也会发生变化(因为现在它们已经是有着不同名字的同一个
# 东西)
#
#

$foo = 'foo scalar';
@foo = 1 .. 5;
%foo = qw/one 1 two 2 three 3/;

sub foo {
    "I'm a subroutine";
}


# typeglob 类型团赋值，可以创建变量的别名
*bar = *foo;


print "scalar is <$bar>, array is <@bar>\n";

print "Sub return <", &bar(), ">\n";


# 改变*bar typeglob中变量的值，同时改变了*foo typeglob从变量中的值
$bar = 'bar scalar';
@bar = 6 .. 10;

print "scalar is <$foo>, array is <@foo>\n";
