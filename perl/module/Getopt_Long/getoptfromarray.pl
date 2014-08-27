#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long qw/GetOptionsFromArray/;
use Data::Dump;

my $length ;
#my $ret = GetOptionsFromArray( \@{[@ARGV]}, 'length|l=s' => \$length );
my $ret = GetOptionsFromArray( \@ARGV, 'length|l=s' => \$length );

# perl getopt8.pl -length 1000
print <<EOF;
length	:	$length
EOF
