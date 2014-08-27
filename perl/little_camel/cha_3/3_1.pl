#!/usr/bin/perl

use strict;
use warnings;

my @list;
while(<>){
	chomp;
	push @list,$_;
}
@list = reverse @list ;
print @list,"\n";
