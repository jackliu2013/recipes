#!/usr/bin/perl

#
# 数组的哈希
# 哈希的每一个元素是数组(其实是数组的引用)

use strict;
use warnings;
use Data::Dump;

#  Declaration of a HASH OF ARRAYS
# hasf of arrays,means that this is a hash,and the values of it's key is arrays

my %HoA = (
           flintstones   => [ "fred", "barney" ],
           jetsons       => [ "george", "jane", "elroy" ],
           simpsons      => [ "homer", "marge", "bart" ],
);
Data::Dump->dump ( %HoA );
