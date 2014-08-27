#!/usr/bin/perl
use strict;
use warnings;

use Data::Dump;

#ARRAYS OF ARRAYS
#   Declaration of an ARRAY OF ARRAYS
#        @AoA = (
#               [ "fred", "barney" ],
#               [ "george", "jane", "elroy" ],
#               [ "homer", "marge", "bart" ],
#             );

#   Generation of an ARRAY OF ARRAYS
# reading from file
#my $file="array.txt";
my @AoA = ();

#open FN,$file or die "Cannot open file:$!\n";
#    while ( <FN> ) {
while (<>) {
    push @AoA, [split];
}
print Data::Dump->dump(@AoA);

# calling a function
# 暂时还没测试
# for $i ( 1 .. 10 ) {
#     $AoA[$i] = [ somefunc($i) ];
# }

# using temp vars
# 暂时还没测试
# for $i ( 1 .. 10 ) {
#     @tmp = somefunc($i);
#     $AoA[$i] = [ @tmp ];
# }

# add to an existing row
warn "---------向数组中的元素追加数据";
@AoA = ( [ "hello", "jack" ], [ "hello", "lucy" ] );
push @{ $AoA[0] }, "wilma", "betty";    #向第1行追加数据
Data::Dump->dump(@AoA);

# Access and Printing of an ARRAY OF ARRAYS
# one element #my @AoA = (
#       [ "fred", "barney" ],
#       [ "george", "jane", "elroy" ],
#       [ "homer", "marge", "bart" ],
#     );
#$AoA[0][0] = "Fred";
#print Data::Dumper->Dump([\@AoA]);

# another element
#my @AoA = (
#       [ "fred", "barney" ],
#       [ "george", "jane", "elroy" ],
#       [ "homer", "marge", "bart" ],
#     );
#$AoA[1][1] =~ s/(\w)/\u$1/;	#将AoA的[1][1]元素的单词的首字母大写
#print Data::Dumper->Dump([\@AoA]);

# print the whole thing with refs
#my @AoA = (
#       [ "fred", "barney" ],
#       [ "george", "jane", "elroy" ],
#       [ "homer", "marge", "bart" ],
#     );
#my $aref;
#for $aref ( @AoA ) {
#    print "\t [ @$aref ],\n";
#}

# print the whole thing with indices
#my @AoA = (
#       [ "fred", "barney" ],
#       [ "george", "jane", "elroy" ],
#       [ "homer", "marge", "bart" ],
#     );
#for my $i ( 0 .. $#AoA ) {
#    print "\t [ @{$AoA[$i]} ],\n";
#}

# print the whole thing one at a time
#my @AoA = (
#       [ "fred", "barney" ],
#       [ "george", "jane", "elroy" ],
#       [ "homer", "marge", "bart" ],
#     );
#for my $i ( 0 .. $#AoA ) {
#    for my $j ( 0 .. $#{ $AoA[$i] } ) {
#        print "elt $i $j is $AoA[$i][$j]\n";
#    }
#}
