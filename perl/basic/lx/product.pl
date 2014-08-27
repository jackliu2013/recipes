#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

my $href;
while (<>) {
    next unless /\d+\s*\w*\s*\w*/;

    ##去掉行首行尾空格
    s/^\s*|\s*$//g;

    #Data::Dump->dump($_);

    my ( $who, $k1, $value ) = split;

    push @{ $href->{$who}->{$k1} }, $value;
}
Data::Dump->dump($href);
