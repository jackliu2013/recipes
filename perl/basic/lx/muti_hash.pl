#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $file ="sale.txt";
my %hoh=();
open FH,$file or die "Can not open file:$!\n";
while (<FH>){
	next unless s/^(\d+)\s*(\d+)\s*(\d+)\s*(\w*)\s*(\d+)// ;
	#print "$1,$2,$3,$4,$5\n"	
	push @{$hoh{$1}{$2}{$3}{$4}},$5;
}
print Data::Dumper->Dump([\%hoh]);
