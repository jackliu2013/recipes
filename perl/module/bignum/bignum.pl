#!/usr/bin/env perl

use strict;
use warnings;

use bignum;
use Data::Dump;


my $a = 1;

print $a . "\n";
Data::Dump->dump($a->copy());
