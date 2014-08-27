#!/usr/bin/perl 

use strict;
use warnings;
use Data::Dump;


my $file = $ARGV[0];
Data::Dump->dump($file);


system("db2 import from $file of del insert into source_jsck");
