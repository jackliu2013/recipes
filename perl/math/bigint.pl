#!/usr/bin/env perl

use strict;
use warnings;

use Math::BigInt;

my $x = Math::BigInt->new('1.01E2');
my $y = Math::BigInt->new('1000E-2');

my $z = Math::BigInt->new('123_456_789_123_456');

warn "$x";
warn "$y";
warn "$z";


# get a zero  
my $zero = Math::BigInt->bzero();
warn "$zero";

# get a NaN(NotANumber)
my $nan = Math::BigInt->bnan();
warn "$nan";

