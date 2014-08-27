#
# 标量捆绑方法  demo1
# 实现一个绑定的标量，类必须定义下面的方法(可能还有DESTROY)
# TIESCALAR:绑定一个标量
# FETCH:读取绑定的变量
# STORE:给变量赋值
#
# 当存在DESTROY时，当指向被绑定对象的最后一个引用消失时，会调用此方法
#! /usr/bin/perl

package Centsible;

sub TIESCALAR { bless \my $self, shift }
sub STORE { ${ $_[0] } = $_[1] }    # 做缺省的事情
sub FETCH { sprintf "%0.2f", ${ my $self = shift };} #对值进行四舍五入

package main;

# 绑定标量
tie $bucks, "Centsible";			# 当此行注释掉后，$bucks = 51.66505125
$bucks = 45.00;
$bucks *= 1.0715;                   # 税
$bucks *= 1.0715;                   # 和双倍的税!
print "That will be $bucks, please.\n";
