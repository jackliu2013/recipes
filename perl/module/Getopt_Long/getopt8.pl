#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Data::Dump;

my $width = 80;
sub process { 
	print "hello $_[0]\n";	# print 传来的参数
}
GetOptions( 'width=i' => \$width, '<>' => \&process );

# perl getopt8.pl arg1 --width=72 arg2
print <<EOF;
width	:	$width
EOF
