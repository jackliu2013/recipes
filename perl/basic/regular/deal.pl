#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dump;

my $filename = 'fund-0002-20130606.bat';
open FH, $filename or die "cannot open $filename $!\n";

#Data::Dump->dump($fh);
while (<FH>) {

    #Data::Dump->dump($_);
    no strict 'refs';
    chomp;
    my $row = [ split '\|', $_ ];

    #Data::Dump->dump( $row->[0], $row->[1], $row->[2], $row->[3] );
    $row->[2] =~ /(\d{4}-\d{2}-\d{2})/;
    Data::Dump->dump( $1 );
}
