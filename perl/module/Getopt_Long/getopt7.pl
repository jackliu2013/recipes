#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;
use Getopt::Long;

my $len = 0;

######### demo 1 ###########
my %h = ( 'length' => \$len );
GetOptions( \%h, 'length=i' );    # will store in $len
Data::Dump->dump( \%h );

######## demo 2 ############
# GetOptions( 'length=i' => \$len );
# Data::Dump->dump( $len );
