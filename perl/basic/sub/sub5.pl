#一个函数,能够返回一个列表,
#这个列表包含在每个传入的散列结构中都出现的键字.

#############################################
# 此段代码暂有BUG，返回的列表为空
#############################################

#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dump;

my %foo = (
    a => 1,
    b => 2
);

my %bar = (
    d => 1,
    c => 2
);

my %joe = (
    a => 1,
    d => 2);

my @common = inter( \%foo, \%bar, \%joe );
Data::Dump->dump(@common);
Data::Dump->dump(\@common);

sub inter {
    my %seen;
    my @arr;
    for my $href (@_) {
        while ( my $k = each %$href ) {

            #Data::Dump->dump($k);
            $seen{$k}++;

            #Data::Dump->dump( $k, $seen{$k} );
        }
    }

    @arr = grep { $seen{$_} == @_ } keys %seen;
    return @arr;
}
