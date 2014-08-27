#!/usr/bin/perl

use strict;
use warnings;

use Data::Dump;

my @array = qw/1 2 3 4 5/;

my $b = join "\n", map { $_ } @array;
print "$b" . "\n";

my $c = join "|", map { $_ } @array;
print "$c\n";
