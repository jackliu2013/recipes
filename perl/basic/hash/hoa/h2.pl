#!/usr/bin/perl

use strict;
use warnings;

use Data::Dump;

#Generation of a HASH OF ARRAYS
# reading from file
# flintstones: fred barney wilma dino
#my $file="hash.txt";
#my %HoA={};
#my $i=0;
#open FN,$file or die "Cannot open file:$!\n";
#while ( <FN> ) {
#    next unless s/^(.*?):\s*//;
#    $HoA{$i} = [ split ];
#    $i ++;
#}
#print Data::Dumper->Dump([\%HoA]);

# reading from file; more temps
# flintstones: fred barney wilma dino
#my $file="hash.txt";
#my %HoA=();
#my $line;
#my $who;
#my $rest;
#my @fields;
#open FN,$file or die "Cannot open file:$!\n";
#while ( $line = <FN> ) {
#    ($who, $rest) = split /:\s*/, $line, 2;	#拆分后的2个字串分别赋值给$who,$rest
#    @fields = split ' ', $rest;			#对$rest按空格拆分，拆分后赋值给@fields数组，当作value
#    $HoA{$who} = [ @fields ];			#对key是$who的value进行赋值
#}
#print Data::Dumper->Dump([\%HoA]);

# calling a function that returns a list
# 暂时还没有测试
#for $group ( "simpsons", "jetsons", "flintstones" ) {
#    $HoA{$group} = [ get_family($group) ];
#}

# likewise, but using temps
# 暂时还没有测试
#for $group ( "simpsons", "jetsons", "flintstones" ) {
#    @members = get_family($group);
#    $HoA{$group} = [ @members ];
#}

# append new members to an existing family
#my %HoA=(
#	flintstones => ["hello","world"]
#);
#push @{ $HoA{"flintstones"} }, "wilma", "betty";
#print Data::Dumper->Dump([\%HoA]);

#Access and Printing of a HASH OF ARRAYS
# one element
#my %HoA=();
#$HoA{flintstones}[0] = "Fred";
#print Data::Dumper->Dump([\%HoA]);

# another element
#my %HoA=(
#	simpsons => ["Hello","world","byebye"]
#);
#$HoA{simpsons}[1] =~ s/(\w)/\u$1/;
#print Data::Dumper->Dump([\$HoA{simpsons}[1]]);

# print the whole thing
#my %HoA = (
#   flintstones   => [ "fred", "barney" ],
#   jetsons       => [ "george", "jane", "elroy" ],
#   simpsons      => [ "homer", "marge", "bart" ],
#);
#foreach my $family ( keys %HoA ) {
#    print "$family: @{ $HoA{$family} }\n"
#}

# print the whole thing with indices
#my %HoA = (
#   flintstones   => [ "fred", "barney" ],
#   jetsons       => [ "george", "jane", "elroy" ],
#   simpsons      => [ "homer", "marge", "bart" ],
#);
#my $i,my $family;
#foreach $family ( keys %HoA ) {
#    print "family: ";
#    foreach $i ( 0 .. $#{ $HoA{$family} } ) {
#        print " $i = $HoA{$family}[$i]";
#    }
#    print "\n";
#}

# print the whole thing sorted by number of members
#my %HoA = (
#   flintstones   => [ "fred", "barney" ],
#   jetsons       => [ "george", "jane", "elroy" ],
#   simpsons      => [ "homer", "marge", "bart" ],
#);
#foreach my $family ( sort { @{$HoA{$b}} <=> @{$HoA{$a}} } keys %HoA ) {
#    print "$family: @{ $HoA{$family} }\n"
#}

# print the whole thing sorted by number of members and name
my %HoA = (
    flintstones => [ "fred",   "barney" ],
    jetsons     => [ "george", "jane", "elroy" ],
    simpsons    => [ "homer",  "marge", "bart" ],
);

foreach
  my $family ( sort { @{ $HoA{$b} } <=> @{ $HoA{$a} } || $a cmp $b } keys %HoA )
{
    print "$family: ", join( ", ", sort @{ $HoA{$family} } ), "\n";
}

