#!/usr/bin/perl

#
# 哈希的哈希
#
#use strict;
use warnings;
use Data::Dump;

# Declaration of a HASH OF HASHES,means that this is a hash,and it's key/value is hash again
my %HoH = (
    
    flintstones => {
        lead => "fred",
        pal  => "barney",
    },

    jetsons => {
        lead      => "george",
        wife      => "jane",
        "his boy" => "elroy",
    },
    
    simpsons => {
        lead => "homer",
        wife => "marge",
        kid  => "bart",
    },
    
);

warn "-------------打印hash的地址";
print "%HoH\n";    #打印哈希的地址

##########根据一个key得到该key对应的value
# $tmpH 是一个哈希引用
warn "-------------1哈希引用使用访问key/value对";
my $tmpH = $HoH{flintstones};
warn "-----哈希引用使用------";
print "$tmpH\n";    # 打印出来的是地址
#Data::Dump->dump($tmpH);
warn "===============================";
print "$tmpH->{lead}\n";
print "$HoH{flintstones}->{lead}\n";
print "$HoH{flintstones}{lead}\n";

##########根据多个key得到多个key对应的value list
# @tmpa 是一个引用数组
warn "-------------2哈希引用使用访问key/value对";
my @tmpa = @HoH{ "flintstones", "simpsons" };
warn "-----哈希引用使用-------";
print "$tmpa[0]->{pal}\n";
print "$tmpa[1]->{wife}\n";

#print Data::Dumper->Dump([@tmpa]);
#print "@tmpa\n";
#print "$tmpa[0]\n"; #打印出来的是地址
#print "$tmpa[1]\n"; #打印出来的是地址

#Data::Dump->dump( [ $tmpa[0] ] );
#Data::Dump->dump( [ $tmpa[1] ] );
