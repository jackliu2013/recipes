#!/usr/bin/env perl

use strict;
use warnings;
use Carp;

open (FILE, 'test/aa') or confess "cannot open test/aa $@";

my $arr = <FILE>;
# print $arr . "\n";
if ($arr =~ /1111/) {
   print "match\n" ;
}
print $arr;
