#!/usr/bin/env perl

use strict;
use warnings;


my $c ;
my $d ;
my $money = '10' ; 
my $a = '0.97' ;
my $b = '0.90' ;
#my $a ;
#my $b ;

#
# $a - $b >= 0  利润$c 大于0 ，否则$c为0
# $b - $a > 0   损失$d 大于0 ，否则$d为0
#

$c = ($a - $b >= 0) ? ( $money * ($a - $b) || 0 ) : 0 ;
$d = ($b - $a > 0) ? ( $money * ($b - $a) || 0 ) : 0 ;
print "now the \$c value is :$c\n" ;
print "now the \$d value is :$d\n" ;

# $d = $money * $a ;
# print " the value of \$d is $d\n" ;
