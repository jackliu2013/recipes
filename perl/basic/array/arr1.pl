#!/usr/bin/perl

use strict;
use warnings;

my @arr = qw/hello world baby/;
print "the array is [@arr]\n";
print "the array is " . join( "|", @arr ) . "\n";

#delete @arr[0..1];
delete $arr[0];
print "arr is [@arr]" . "\n";
