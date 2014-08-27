#!/usr/bin/perl
use strict;
use warnings;

sub make_saying {
	my $salute = shift;
	#print "$salute\n"; #
	my $newfunc = sub {
	    my $target = shift;
		print "$salute, $target!\n";
	};
	return $newfunc;		# 返回一个闭合
}
my $f = make_saying("Howdy");		# 创建一个闭合
my $g = make_saying("Greetings");	# 创建另外一个闭合
# 到时...
$f->("world");
$g->("earthings");
#它打印出:
#Howdy, world!
#Greetings earthlings!
