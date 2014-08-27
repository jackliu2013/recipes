#!/usr/bin/env perl

use strict;
use warnings;

use Data::Hexdumper;


my $data = '1234567890123456789';

print hexdump(
    data           => $data,    # what to dump NB number_format is deprecated
    number_format  => 'S'      # display as unsigned 'shorts'
    # start_position => 100,      # start at this offset ...
    # end_position   => 148       # ... and end at this offset
);


warn "---------------------";
print hexdump( "abcdefg", { output_format => '%4a : %C %S< %L> : %d' } );
