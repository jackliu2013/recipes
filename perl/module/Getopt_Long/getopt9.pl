#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use Getopt::Long;

my $length ;
my $rtn = GetOptions ('l|length=i' => \$length ) ;

&usage unless ( $rtn ) ;

print <<EOF;
l|length : $length
EOF

sub usage {
    print <<EOF;
usage : ./getopt9.pl -l|length num
EOF
    exit -1 ;
}
