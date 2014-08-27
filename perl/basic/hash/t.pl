#!/usr/bin/env perl

use strict;
use warnings;

my %hash = (
            1 => 'hello',
            2 => 'world',
            3 => 'china',
        );

my $val1 = $hash{3} ;
print "$val1\n" ;

my $val2 = $hash{4} ;
print "$val2\n" ;

my $val3 = $hash{''} ;
print "$val3\n" ;
