#!/usr/bin/perl
use strict;
use warnings;

use IO::File;
use Data::Dump;


# c.dat 为要选择的要素的文件
# b.dat 为所有要素组成的matcher文件
# d.dat 为根据c.dat中的选择要素查找出的对应匹配的matcher
#
#
my $fhr1 = IO::File->new( "c.dat", "r" );
my $fhr2 = IO::File->new( "b.dat", "r" );
my $fhw  = IO::File->new( "d.dat", "a+" );

my @arr1 = <$fhr1>;
my @arr2 = <$fhr2>;
my ( $line1, $line2 );

for $line1 (@arr1) {
    my @arr;
    my $count_i;
    chomp $line1;
    s/^\s*|\s*$//g ;
    next if $line1 =~ /^$/ ; 
    @arr = split '\*', $line1;

    for ( my $i = 0 ; $i < @arr ; $i++ ) {
        next if $arr[$i] eq '';
        $count_i++;
    }
    Data::Dump->dump( @arr ) ;

    for $line2 (@arr2) {
        my $i       = 0;
        my $count_j = 0;
        chomp $line2;
        my %ret;
        my @res = split '\*', $line2;
        map { $ret{$_} = $i++ } @res;

        #Data::Dump->dump( \%ret );
        for ( my $j = 0 ; $j < @arr ; $j++ ) {
            next if $arr[$j] eq '';

            $count_j++ if exists $ret{ $arr[$j] };
        }

        #Data::Dump->dump( $count_i, $count_j );

        if ( $count_i == $count_j ) {
            $fhw->print("$line2,");
        }
    }
    $fhw->print("\n================\n");

}

#Data::Dump->dump( \$arr );
undef $fhr1;
undef $fhr2;
undef $fhw;
