#!/usr/bin/env perl

package ClockArray;
use Tie::Array;
our @ISA = 'Tie::StdArray';

sub FETCH {
    my ($self, $place) = @_;
    $self->[ $place % 12 ];
}

sub STORE {
    my ($self, $place, $value) = @_;
    $self->[ $place % 12 ] = $value;
}

package main;

tie my @array, 'ClockArray';

@array = ( 'a' ... 'z' );
print "@array\n";

__END__
此类提供了一个只有12个位置的数组，类似一个时钟的小时数，编号为0到11，
如果请求第15个元素，实际上获取的是第3个元素
