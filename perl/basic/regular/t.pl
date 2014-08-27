#!/usr/bin/env perl

use strict;
use warnings;


my $a = '2013-08-20 10:00:00.000000';

$a =~ /(\d{4})\-(\d{2})\-(\d{2})/;

my $b = $1 . '-' . $2 . '-' . $3 ;

printf "$b";


my $c = 0.099999 ;

if ( $c =~ /^\d+.\d{2}$/ ) {
    print $c ;
}

