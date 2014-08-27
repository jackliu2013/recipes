#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/neat/;

my ( $a, $maxlen, $desc );

$a    = 'abc';
$desc = neat($a);
Data::Dump->dump($desc);

$a = 'hello world';
$desc = neat( $a, $maxlen );
Data::Dump->dump($desc);
