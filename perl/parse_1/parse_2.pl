#!/usr/bin/env perl

use strict;
use warnings;
use IO::File;

my $fh1 = IO::File->new(">sequence.text");
my $fh2 = IO::File->new(">date.text");

while (<>) {

    my @data = split /\s+/, $_;
    $fh2->print( join ' ', @data[ 1, 3 ], "\n" );
    $fh1->print( $data[2], "\n" );

}
