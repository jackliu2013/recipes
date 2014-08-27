#!/usr/bin/env perl

#
# perl split.pl test/aa
#
#
#use strict;
#use warnings;
use Data::Dump;

while(<>){
    chomp;
    warn "$_\n";
    my $row = [ split '\|' ] ;
     
    print @$row . "\n";
     
    foreach my $a ( @$row ) {
        if ( defined $a ) {
            printf "$a is defined\n";
        }
        else {
            printf "$a is undefined\n";
        }
    }

    Data::Dump->dump( $row ) ; 
}
