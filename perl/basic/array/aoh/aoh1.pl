#!/usr/bin/perl

#
# 哈希数组
#
use strict;
use warnings;
use Data::Dump;

# Declaration of an ARRAY OF HASHES
# array of hashes,means that this is a array,and it's element is hash.

my @AoH = (

    {
        Lead   => "fred",
        Friend => "barney",
    },

    {
        Lead => "george",
        Wife => "jane",
        Son  => "elroy",
    },

    {
        Lead => "homer",
        Wife => "marge",
        Son  => "bart",
    },
);

Data::Dump->dump(@AoH);

warn "-------------打印数组里的每个元素";
for my $i ( 0 .. $#AoH ) {
    # 打印数组里的每个元素
    Data::Dump->dump( $AoH[$i] );
}
