#!/usr/bin/env perl

use strict;
use warnings;

use Math::BigInt;

Math::BigInt->precision(4);

my $a = 1.11100;
my $b = 1.00000;
my $c = $a+$b;
#my $d = sprintf("%.4f\n", $c);
#warn "$d";

warn "$c";
