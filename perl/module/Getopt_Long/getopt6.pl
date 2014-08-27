#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use Data::Dump;

my %h;

#GetOptions( \%h, 'length=i' );    # will store in $h{$length}
#Data::Dump->dump( \%h );          # if exists $h{$length} ;

################################
# perl getopt6.pl -length 112
# perl getopt6.pl -length=112
# perl getopt6.pl --length 12
# perl getopt6.pl --length=12
################################

GetOptions( \%h, 'colours=s@' );   # will store in $h{$length}
Data::Dump->dump( \%h );           # if exists $h{$length} ;

################################
# perl getopt6.pl -colours 112 -colours 13 -colours 14
# perl getopt6.pl -colours=112 -colours 13 -colours 14
# perl getopt6.pl --colours 12 -colours 13 -colours 14
# perl getopt6.pl --colours=12 -colours 13 -colours 14
################################
