#!/usr/bin/env perl

use warnings;
use Data::Dump;

my ( @key, @value );
while (<>) {
    s/\s*//g;

    # Data::Dump->dump($_);
    my $row = [ split '\|', $_ ];

    # Data::Dump->dump($row->[0],$row->[2]);
    push @key, $row->[0];
}
# Data::Dump->dump(@key);


