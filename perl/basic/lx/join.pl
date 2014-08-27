#!/usr/bin/perl

use strict;
use warnings;
use Env qw/HOME SHELL/;

my $rec = join('|',$HOME,$SHELL);
print "$rec\n";
