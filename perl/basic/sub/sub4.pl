#几个数组传入一个函数,并且使用使用 pop 得到每个数组的最后一个元素,
#并返回每个数组最后一个元素组成的一个新的数组:

#!/usr/bin/env perl -w
use strict;
use Data::Dump;

my @a = qw/h e l l o/;
my @b = qw/h e l l p/;
my @c = qw/h e l l e/;
my @d = qw/h e l l n/;

my @tailings = popmany( \@a, \@b, \@c, \@d );
Data::Dump->dump(\@tailings);
Data::Dump->dump(@tailings);

sub popmany {

    # 定义一个空数组
    my @retlist = ();
    for my $aref (@_) {
        push @retlist, pop @$aref;
    }
    return @retlist;
}
