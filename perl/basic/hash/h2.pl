#!/usr/bin/env perl

#
# 改变hash中key的value
#

use strict;
use warnings;
use Data::Dump;

my $c   = "nihao";
my %Hoh = (
    a => "hello",
    b => "world"
);

print "改变hash Hoh之前的数据\n";
Data::Dump->dump( \%Hoh );

warn "-----------改变hash中key的值";
my @va = $Hoh{a};
push @va, $c;    #push nihao after hello

# print "@va\n";	#print hello nihao
$Hoh{a} = \@va;
print "改变\$Hoh{a}的值为@va\n";
print "改变hash Hoh之后的数据\n";

Data::Dump->dump( \%Hoh );    #	a => ["hello","nihao"], b => "world"

$Hoh{a} = $c;

Data::Dump->dump( \%Hoh );    #	a => "nihao", b => "world"
