#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $file ="product.txt";
my %hpro=();
my @key;
my $i=0;
my @value;
my @tkey;
my @tmp;
my @tmp2;
open FH,$file or die "Can not open file:$!\n";
while (<FH>){
	next unless s/^(\d+)\s*(\w*)\s*(\w*)//;
	#print "$1,$2,$3\n";		
	$hpro{$1}{$2}=$3;	
	@key = keys %{$hpro{$1}};
	push @tkey,$key[0];
	#@value = values %{$hpro{$1}};
	#print "@key\t$2\n";	#这两行打印出HN，HB
	#print "@value\t$3\n";
	#if (exists $key[0]){
	if($2 eq $tkey[$i-1]){
	 push @tmp,$3;
	 #print "@value\t$3\n";
	 $hpro{$1}{$2}=[@tmp];	
	}
	else{
	@tmp=();
	}
	$i ++;
}
print Data::Dumper->Dump([\%hpro]);
