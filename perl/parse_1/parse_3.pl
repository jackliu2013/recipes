#!/usr/bin/env perl

use strict;
use warnings;
use IO::File;

my $fhi = IO::File->new("<result.txt");
my $fho = IO::File->new(">out.txt");

my $flag = 0;

while (<$fhi>) {

    #找到起始点,第一个config user local
    if (/^\s*config user local\s*$/) {
        $flag = 1;
        $fho->print( "$_", "\n" );
    }

#找到终止点,config user local之后的第一个end, 重置起始标志并退出循环, 此处不重置也ok
    elsif ( /^\s*end\s*$/ && $flag == 1 ) {
        $flag = 0;
        $fho->print( "$_", "\n" );
        last;
    }
    else {
        $fho->print( "$_", "\n" ) if $flag == 1;
    }
}
