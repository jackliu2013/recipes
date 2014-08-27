#!/usr/bin/env perl
# basic-arithmetic.pl

use strict;

while(1) {
    my ( $operator, @operand ) = get_line();

    if    ( $operator eq '+' ) { add ( @operand ) }
    elsif ( $operator eq '-' ) { substract ( @operand ) }
    elsif ( $operator eq '*' ) { multiply ( @operand ) }
    elsif ( $operator eq '/' ) { divied ( @operand ) }
    else {
        print "No such operator { $operator }!\n";
        last;
    }
}

print "Done, exiting...\n";

sub get_line {

    # 我们可以把它变得更复杂一些，但是它不是我们关心的重点
    print "\nprompt> ";

    my $line = <STDIN>;

    # 去除行首行位空格
    $line =~ s/^\s+|\s+$//g;

    # 空格拆分输入，返回一个输入的列表,列表是 操作符号 操作数1 操作数2
    ( split /\s+/, $line )[1, 0, 2]; 
}

sub add { print $_[0] + $_[1] }

sub substract { print $_[0] - $_[1] }

sub multiply { print $_[0] * $_[1] }

sub divied { print $_[1] ? $_[0] / $_[1] : 'Nan' }
