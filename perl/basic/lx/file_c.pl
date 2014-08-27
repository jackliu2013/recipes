#!/usr/bin/perl
use strict;
use warnings;

use IO::File;
use Data::Dump;

my $fhr  = IO::File->new( "c.dat", "r" );
my $fhw  = IO::File->new( "d.dat", "w" );

my @arr;
my @res;
my $count_i;

while (<$fhr>) {
    chomp;
    @arr = split '\*', $_;

    for ( my $i = 0 ; $i < @arr ; $i++ ) {
        next if $arr[$i] eq '';
        $count_i++;
    }
}

$fhr = IO::File->new( "b.dat", "r" );
while (<$fhr>) {
    my $i       = 0;
    my $count_j = 0;
    chomp;
    my %ret;
    @res = split '\*', $_;
    map { $ret{$_} = $i++ } @res;

    #Data::Dump->dump( \%ret );
    for ( my $j = 0 ; $j < @arr ; $j++ ) {
        next if $arr[$j] eq '';

        $count_j++ if exists $ret{ $arr[$j] };
    }
    #Data::Dump->dump( $count_i, $count_j );

    if ( $count_i == $count_j ) {
        $fhw->print("$_\n");
    }

    #Data::Dump->dump("=====================\n");
}

#Data::Dump->dump( \$arr );
undef $fhr;
undef $fhw;
