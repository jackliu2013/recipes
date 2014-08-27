#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/data_diff/;

my ( $a, $b, $desc );

$a    = 'abc';
$b    = 'ab\x{263a}';
$desc = data_diff( $a, $b );
Data::Dump->dump($desc);
