#!/usr/bin/perl
use strict;
use warnings;

my $str1 = "hello world.";
my @array1 = ("how","old","are you");
my %hash1 = ( you => "ILOVE",
	    he => "byebye");
my @whos = keys %hash1;

print "$str1\n";
print "@array1\n";
#print $hash1{"you"};
print @whos[0..$#whos];
print "\n";
