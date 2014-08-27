#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

my $href;
while (<>) {
    next unless s/^(.?)\s*//;

    my $who = $1;

    #Data::Dump->dump($who);

    for my $fld (split) {
        next unless s/(\w*)\_(\w\=\d)//;
        my $k1 = $1;

        #Data::Dump->dump($k1);
        my ( $k2, $value ) = split /=/, $2;

        #Data::Dump->dump($k2);
        #Data::Dump->dump($value);

        #Data::Dump->dump(${$href->{$who}->{$k1}}{$k2});
        $href->{$who}->{$k1}->{$k2} =
          exists $href->{$who}->{$k1}->{$k2}
          ? $href->{$who}->{$k1}->{$k2} + $value
          : $value;

    }

}
Data::Dump->dump($href);
