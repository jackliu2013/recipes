#!/usr/bin/perl

use strict;
use warnings;

my @files ;
@files = qw/hello ha boy/;
my @articles ;

# sort lexically 词法排序
@articles = sort @files;
print "@articles\n" ;

# same thing, but with explicit(明显) sort routine
@articles = sort {$a cmp $b} @files;
print "@articles\n";

# now case-insensitively 忽略大小写 一律大写
@articles = sort {uc($a) cmp uc($b)} @files;
print "uc sort :@articles\n";

@articles = sort {lc($a) cmp lc($b)} @files;
print "lc sort :@articles\n";

# same thing in reversed order
@articles = sort {$b cmp $a} @files ;
print "@articles\n";


@files = qw/11 12 9 8/ ;
# sort numerically ascending	对数字递增排序	
@articles = sort {$a <=> $b} @files;
print "@articles\n";

# sort numerically descending	对数字递减排序
@articles = sort {$b <=> $a} @files;
print "@articles\n";
