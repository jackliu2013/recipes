#定义一个函数,这个函数使用数组的引用作为参数.
#当这个数组非常大时,作为一个引用传递要比传入一长列值要快得多:

#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dump;

my @a     = qw/1 2 3 4 5 6 7 8 9 10/;
my $total = sum( \@a );
Data::Dump->dump($total);

sub sum {
    my ($aref)  = @_;
    my ($total) = 0;
    foreach (@$aref) { $total += $_ }
    return $total;
}
