#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

=p 多行注释
array of arrays,means that the array's element is arrays
数组的数组即二维数组,二维数组的元素是数组的引用
=cut

my @AoA = ( [ 2, 3 ], [ 4, 5, 7 ], [ 1 .. 6 ] );
warn "-----\@AoA------";
warn "---\$AOA[1][2]---begin";
print "$AoA[1][2]\n";    # 打印出 [4,5,7]中的7
warn "------------------end";

warn "----打印出数组的地址------";
print @AoA, "\n";        # 打印出数组元素的地址
warn "-------------------------";

warn "------------------address bgein";
print $AoA[0], "\n";     # 打印@AoA第一个元素的地址
print $AoA[1], "\n";     # 打印@AoA第二个元素的地址
print $AoA[2], "\n";     # 打印@AoA第三个元素的地址
warn "------------------address end";
warn "------------------开始打印二维数组元素";
print "@{$AoA[0]}\n";    # 打印@AoA第一个元素 即 2 3
print "@{$AoA[1]}\n";    # 打印@AoA第二个元素 即 4 5 7
print "@{$AoA[2]}\n";    # 打印@AoA第三个元素 即 1 .. 6
warn "------------------结束打印二维数组元素";

my $i;
my @array;

=p
#####1#####
for $i (1..10){
	@array = 0 .. $i;
	$AoA[$i] = [ @array];
	#print "$AoA[$i]\n"     #打印出$AoA[$i]的地址
	print "@{$AoA[$i]}\n";
}


#####2#####
for $i (1..10){
	@array = 0 .. $i;
	@{$AoA[$i]} = @array;
	#print "$AoA[$i]\n"     #打印出$AoA[$i]的地址
	print "@{$AoA[$i]}\n";
}

#####3#####
for $i ( 1 .. 10 ) {
    @array   = 0 .. $i;
    $AoA[$i] = \@array;    #用到引用，数组的引用
                           #print "$AoA[$i]\n" 	#打印出$AoA[$i]的地址
    print "@{$AoA[$i]}\n";
}

##########another demo#####
#$aref为数组引用
my $aref = [
    [ "fred",   "barney", "pebbles", "bambam", "dino", ],
    [ "homer",  "bart",   "marge",   "maggie", ],
    [ "george", "jane",   "elroy",   "judy", ],
];

#print $aref[2][2];	    #wrong
#print $aref->[2][2];	#print elroy
#print $$aref[2][2];	#print elroy $$aref[2][2]先进行解引用,解引用后aref等同与二维数组，所以print $aref[2][2] ok
