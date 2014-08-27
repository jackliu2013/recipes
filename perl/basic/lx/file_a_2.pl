#!/usr/bin/perl

#
# a.dat文件中一个要素占据一行，行中的数据为该要素的所有取值
# 每行中的数据以逗号分隔
#
# 生成的所有可能的matcher的组合写入b.dat文件
#
#
use strict;
use warnings;
use Data::Dump;

use IO::File;

my ( $fhr, $fhw );
$fhr = IO::File->new( "a.dat", "r" );
$fhw = IO::File->new( "b.dat", "w" );

my $line_count = 0;
my $row;

#print <$fhr>;
while (<$fhr>) {
    chomp;
    $line_count++;
    @{ $row->{$line_count} } = split ',', $_;
}

Data::Dump->dump($row);
my ( $a, $b, $c, $d, $e );

#Data::Dump->dump( $row->{1} ) ;
#foreach $a ( @{$row->{1}} ) {
#    Data::Dump->dump( $a );
#}

foreach $a ( @{ $row->{1} } ) {
    foreach $b ( @{ $row->{2} } ) {
        foreach $c ( @{ $row->{3} } ) {
            foreach $d ( @{ $row->{4} } ) {
                foreach $e ( @{ $row->{5} } ) {
                    $fhw->print("$a*$b*$c*$d*$e\n");
                    #Data::Dump->dump("$a*$b*$c*$d*$e");
                }
            }
        }
    }
}

undef $fhr;
undef $fhw
