#!/usr/bin/env perl
use strict;
use warnings;

use Data::Dump;

my %hash;

### <DATA> 和 __END__ 在一起表明<DATA> 是__END__下面的数据
while(<DATA>) {
    s/^\s+|\s+$//g;
    warn "$_";

    my ($key, @e) = split;
    for (@e) {
        /BUS_(\w+)=(\d+)/;
        $hash{$key}{BUS}{$1} += $2; 
    }
}

Data::Dump->dump(\%hash);

__END__
A      BUS_x=1      BUS_y=2   BUS_z=3   BUS_t=1
B      BUS_x=1      BUS_y=2   BUS_z=3 
A      BUS_x=1      BUS_y=2   BUS_z=3


