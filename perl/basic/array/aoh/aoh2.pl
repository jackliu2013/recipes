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

Data::Dump->dump( @AoH );

######打印哈希数组的每个哈希的key/value
warn "-----------1打印每个hash的key/value";
for my $i ( 0 .. $#AoH ) {
    foreach my $key ( keys %{ $AoH[$i] } ) {
        print "$key => ${$AoH[$i]}{$key}\n";
    }
}

# add key/value to an element
# $AoH[0]{pet} = "dino";
#  $AoH[2]{pet} = "santa's little helper";
#for my $i (0 .. $#AoH){
#	print Data::Dumper->Dump([$AoH[$i]]);
#	print Data::Dumper->Dump([$AoH[$i]]),"\n";
#}

# 访问 修改 哈希数组中的key/value对
warn "----------2访问修改哈希数组中的key/value对";
$AoH[0]{lead} = "hello";
print "$AoH[0]{lead}\n";

$AoH[1]{Lead} =~ s/(\w)/\u$1/;
print "$AoH[1]{Lead}\n";

# 哈希数组的每个元素其实是哈希引用
# 打印哈希数组每个元素
#  
warn "----------3";
my $href;
my $role;
for $href (@AoH) {
    print "{ ";
    for $role ( keys %$href ) {
        print "$role=>$href->{$role} ";
    }
    print "}\n";
}

# print the whole thing with indices
warn "-----------4";
for my $i ( 0 .. $#AoH ) {
    print "$i is { ";
    for my $role ( keys %{ $AoH[$i] } ) {
        print "$role=$AoH[$i]{$role} ";
    }
    print "}\n";
}

# print the whole thing one at a time
warn "------------5";
for my $i ( 0 .. $#AoH ) {
    for my $role ( keys %{ $AoH[$i] } ) {
        print "elt $i $role is $AoH[$i]{$role}\n";
    }
}

