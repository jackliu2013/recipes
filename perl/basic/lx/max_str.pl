#!/usr/bin/perl

use warnings;
use Data::Dump;

my @arr = qw/a b c d 1 2 3 4 5 6 7 8 9 a s f j s j w/;
#Data::Dump->dump($#arr);
my $r = max_str(@arr);
Data::Dump->dump($r);

sub max_str {
	my $ret;
	my ($i,$j) = 0;
	for($i; $i < $#_; $i++) {
		for($j = $i + 1 ; $j < $#_ ; $j++) {
			if ($_[$j] + 1 cmp $_[$j+1]) {
					next;
			}
			else {
				$ret = \@_[$i .. $j];
				last;
			}
		}
	}
	return $ret ;
}
