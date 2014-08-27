#!/usr/bin/env perl

use strict;
use warnings;


my @arr = qw/F0033 F0012 F0013/;

@arr = sort { $a cmp $b } @arr ;

printf"@arr\n";
