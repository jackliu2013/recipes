#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/looks_like_number/;

my @array = ( 1, 'hello', 3, 4, undef, 6 );
my @bool = looks_like_number(@array);
for ( my $i = 0 ; $i < @bool - 1 ; $i++ ) {
    Data::Dump->dump( $array[$i] ) if $bool[$i];
}
