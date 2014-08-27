#!/usr/bin/perl
use strict;
use warnings;
#use Data::Dumper;
use Data::Dump;

my $file="ini.txt";
my $cur_sec;
my %hoh;
open FN,$file or die "Cannot open file:$!\n";
while (<FN>){
	next if /^$/;
	#Data::Dump->dump($_);
	$cur_sec = $1 and next if (/^\[(\w+)]/);
	#Data::Dump->dump($1);
	if ( /(\w+)\s+\=\s+(\w+)/ ){
		#Data::Dump->dump($1,$2);	
		#push @{$hoh{$cur_sec}{$1}},$2;
		$hoh{$cur_sec}{$1}=$2;
	}
}
Data::Dump->dump(%hoh);
