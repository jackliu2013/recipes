#!/usr/bin/perl

use strict;
use warnings;

my ($fred, $barney);
my @c;

sub list_from_fred_to_barney {
	if($fred < $barney) {
		#Count upwards from $fred to $barney
		$fred .. $barney
	} else {
		#Count downwards from $fred to $barney
		reverse $barney ..$fred;
	}
}
#$fred = 9;
#$barney = 1;
$fred = 1;
$barney = 9;
@c = &list_from_fred_to_barney; #@c 为(9,8,7,6,5,4,3,2,1)
print @c,"\n";
