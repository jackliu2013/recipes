#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/data_string_diff/;

my ( $a, $b, $desc );

$a    = 'hell world';
$b    = 'hell world';
$desc = data_string_diff($a,$b);
Data::Dump->dump($desc);

$a    = 'aaa';
$b    = 'abc';
$desc = data_string_diff($a,$b);
Data::Dump->dump($desc);

$a    = 'aaa';
$b    = undef;
$desc = data_string_diff($a,$b);
Data::Dump->dump($desc);

$a    = 'aaa';
$b    = 'aa';
$desc = data_string_diff($a,$b);
Data::Dump->dump($desc);
