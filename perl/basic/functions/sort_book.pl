#!/usr/bin/env perl

use strict;
use warnings;

my @book;

while(<>){
    if(/(\d+)/) {
       push @book, $1; 
    }
}

# print  "@book\n";
#  对数组中的数组的元素进行排序
print sort { $a <=> $b } map { $_ . ' ' } @book;
print "\n";


# perl sort_book.pl book # 执行方法
#
