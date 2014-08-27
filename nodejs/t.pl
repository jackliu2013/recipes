#!/usr/bin/env perl

use strict;
use warnings;

use IO::File;

my $fh = IO::File->new("<f1.dat");

while(<$fh>) {
    chomp;
    my $ahref = [ split '\|' ];
    if($ahref->[2] =~ /^\d+.\d{2}$/) {
        warn "data is ok\n";
    }
    else {

    }
}
