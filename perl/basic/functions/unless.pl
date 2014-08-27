#!/usr/bin/env perl

use strict;
use warnings;

#
# unless(condition) {
#    command a ;
# }
# 如果条件为假, 则执行 command a
#

my $i = 1;
my $j = 0;

if ($i) {
    print $i . "\n" ;
}

unless ($j) {
    print $j . "\n" ;
}
