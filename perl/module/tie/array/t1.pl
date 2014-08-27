#
# ClockArray类提供一个只有一打位置（12个位置）的数组，编号 0 - 11。
# 如果请求第15个元素，你实际上会获得第3个元素
#
#!/usr/bin/env perl
package ClockArray;
use Tie::Array;
our @ISA = 'Tie::StdArray';

sub FETCH {
    my ( $self, $place ) = @_;
    $self->[ $place % 12 ];
}

sub STORE {
    my ( $self, $place, $value ) = @_;
    $self->[ $place % 12 ] = $value;
}

package main;
tie my @array, 'ClockArray';
@array = ( "a" .. "z" );
print "@array\n";
