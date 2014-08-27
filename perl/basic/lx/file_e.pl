#!/usr/bin/perl

use strict;
use warnings;

use IO::File;
use Data::Dump;

my $fhr1 = IO::File->new( "c.dat", "r" );
my $fhr2 = IO::File->new( "d.dat", "r" );

my @arr1 = <$fhr1>;
my @arr2 = <$fhr2>;

#Data::Dump->dump(@arr1);
#Data::Dump->dump(@arr2);

my ( $line1, $line2 );

for $line1 (@arr1) {
    print $line1, "\n";
    for $line2 (@arr2) {
        print $line2, "\n";
    }

}

undef $fhr1;
undef $fhr2;
