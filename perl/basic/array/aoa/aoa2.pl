#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

=p 多行注释
array of arrays,means that the array's element is arrays
数组的数组即二维数组,二维数组的元素是数组的引用
=cut

my @AoA = ( 
    [ 2, 3 ], 
    [ 4, 5, 7 ], 
    [ 1, 6 ], 
    8, 
    9, 
    { 
        a => 'hello',
        b => 'world',
    }
  );
warn "-----\@AoA------";
foreach (@AoA) {
    # if (ref($_) eq 'ARRAY') {
    #   print map { $_ . "\n"} join(' ', split(',', @$_));
    # }
    if (ref($_) eq 'ARRAY') {
       print map { $_ . ' ' } @$_;
       print "\n";
    }
    elsif (ref($_) eq 'HASH') {
        while(my($key, $value) = each %$_) {
            print "$key=>$value\t";
        }
        print "\n";
    }
    else {
        print $_ . "\n";
    }
}
warn "------------------end";


=p
my $i;
my @array;
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
=cut
