#!/usr/bin/perl

use strict;
use warnings;

=map
map BLOCK LIST
map EXPR,LIST
    Evaluates the BLOCK or EXPR for each element of LIST (locally setting $_ to each element) and returns the list value composed of the results of each such evaluation. In scalar context, returns the total number of elements so generated. Evaluates BLOCK or EXPR in list context, so each element of LIST may produce zero, one, or more elements in the returned value.
=cut

####把numbers中数字转换为对应的字符数据
######translates a list of numbers to the corresponding characters###
my @numbers = qw/66 67/;
my @chars = map( chr, @numbers );
print @chars, "\n";

####translates a list of numbers to their squared values.
@numbers = qw/3 5 6 7/;
my @squares = map { $_ * $_ } @numbers;
#print @squares, "\n";
foreach (@squares) {
	print $_,"\t";
}
print "\n";

#####shows that number of returned elements can differ from the number of input elements. To omit an element, return an empty list (). This could also be achieved by writing
@squares = map { $_ > 5 ? ( $_ * $_ ) : () } @numbers;
#print @squares, "\n";
foreach (@squares) {
	print $_,"\t";
}
print "\n";

####which makes the intention more clear
@squares = map { $_ * $_ } grep { $_ > 5 } @numbers;
#print @squares, "\n";
foreach (@squares) {
	print $_,"\t";
}
print "\n";

