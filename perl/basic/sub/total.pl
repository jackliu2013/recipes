#!/usr/bin/perl 

use warnings;
use strict;

use Data::Dump;


sub my_total {

	my $sum = shift @_ ;
	foreach ( @_ ) {
		$sum += $_ ;	
	}	

	return $sum ;
}

my @arr = (1..1000);
my $total = my_total @arr ;
Data::Dump->dump($total);
