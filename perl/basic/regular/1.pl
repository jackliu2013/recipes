#!/usr/bin/perl

use strict;
use warnings;

my @string = (
	"Fred and Barney",
	"Gilligan or Skipper",
	"Fred and Ginger",
	);

foreach my $string ( @string ) {
	# $string =~ m/(\S+) and|or (\S+)/; # does't work
	$string =~ m/(\S+) (and|or) (\S+)/; 
	print "\$1: $1\n\$2: $2\n\$3: $3\n";
	print "-" x 10,"\n";
}
