#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

#A reference to an anonymous array can be created using square brackets:
my $arrayref = [ 1, 2, [ 'a', 'b', 'c' ] ];
Data::Dump->dump($arrayref);
print $arrayref->[0], "\t";
print $arrayref->[1], "\t";
print $arrayref->[2]->[0], "\t";
print $arrayref->[2]->[1], "\t";
print $arrayref->[2]->[2], "\n";

#A reference to an anonymous hash can be created using curly brackets:

my $hashref = {
    'Adam'  => 'Eve',
    'Clyde' => 'Bonnie',
};
Data::Dump->dump($hashref);
print $hashref->{Adam},"\t";
print $hashref->{Clyde},"\n";

