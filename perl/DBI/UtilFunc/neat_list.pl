#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use DBI qw/neat_list/;

my ( @a, $maxlen, $desc, $field_sep );

@a = qw/abc def/;
$desc = neat_list( \@a, $maxlen, $field_sep );
Data::Dump->dump($desc);

@a = qw/hello world/;
$desc = neat_list( \@a, $maxlen, $field_sep );
Data::Dump->dump($desc);
