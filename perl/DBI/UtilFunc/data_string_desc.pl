#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/data_string_desc/;

my $string = 'hell world';
my $desc   = data_string_desc($string);
Data::Dump->dump($desc);
