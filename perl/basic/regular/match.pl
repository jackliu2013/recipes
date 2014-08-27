#!/usr/bin/perl

use strict;
use warnings;

my $str1="hot cross buns";
if ($str1 =~ /cross/){
	print "Matched: <$`>,$&,<$'>\n"; #Matched: <hot >,cross,< buns>
	print "Left:  <$`>\n";	#Left:  <hot >
	print "Match: <$&>\n";	#Match: <cross>
	print "Right: <$'>\n";	#Right: < buns>
}


$_ = "Bilbo Baggins's birthday is September 22";
/(.*)'s birthday is (.*)/;
print "Person: $1\n";
print "Date: $2\n";

open DICT,"aa.txt" or die "Can't open words: $!\n";
our $last;
our $first;
while (<DICT>) {
	$first = $1 if /(^hello.*)/ ;
	$last = $1 if /(^hello.*)/ ;
}
print ($first,"\n");
# 打印""
print ($last,"\n");
# 打印 ""
# close DICT;

######## 将所以的hello转换成大写######
print "22222222222222222\n";
open DICT,"aa.txt" or die "Can't open words: $!\n";
our $tmp5;
while(<DICT>){
	$tmp5=s/hello|Hello/\u$&/g;
    print "$tmp5\n";
}
close DICT;
