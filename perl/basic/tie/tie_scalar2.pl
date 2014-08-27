#!/usr/bin/env perl

=comment
Tie::Counter是一个简单的类，帮顶到这个类的变量每次自赠1

TIESCALAR 构造器把一个可选的额外参数当作计数器的初始值，缺省为0，
如果给这个计数器赋值将设置一个新值。

=cut

package Tie::Counter;

sub FETCH { ++ ${ $_[0] } }
sub SOTRE { ${ $_[0] } = $_[1] }

sub TIESCALAR {
    my ($class, $value) = @_;
    $value = 0 unless defined $value;

    bless \$value => $class;
}


package main;

#tie my $counter, "Tie::Counter", 100;

#
# 此时调用的TIESCALAR 方法, $value undef
#
tie my $counter, "Tie::Counter";     

@array = qw/red blue green/;

for my $color (@array) {
    print "counter: $counter $color\n";
}
