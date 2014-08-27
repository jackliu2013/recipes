#!/usr/bin/perl
use strict;
use warnings;

my @lines = <STDIN> ;	#读入所有的行
print @lines;
my @list = chomp (@lines);	#去掉所有的换行符
print "@list\n";
