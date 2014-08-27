#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $file = "product.txt";
###############方法1##############
#	my %hpro=();
#	open FH,$file or die "Can not open file:$!\n";
#	while (<FH>){
#		next unless s/^(\d+)\s*(\w*)\s*(\w*)//;
#		#print "$1,$2,$3\n";
#	push @{$hpro{$1}{$2}},$3;
#}
#print Data::Dumper->Dump([\%hpro]);
###############方法2##############
##############第2种方法目前还有问题
my %hpro;
my @fle;
open FH, $file or die "Can not open file:$!\n";
while (<FH>) {

    next unless /^(\d+)\s*(\w*)\s*(\w*)/;
    @fle = split;

    #print "@fle\n";
    #print "$fle[0],$fle[1],$fle[2]\n";
    $hpro{ $fle[0] }{ $fle[1] }{ $fle[2] } = 1;

}

#print Data::Dumper->Dump( [ \%hpro ] );
my $year;
my $prov;
my $product;
for $year ( keys %hpro ) {
    for $prov ( keys %{ $hpro{$year} } ) {
        my @tmp;
        for $product ( keys %{ $hpro{$year}{$prov} } ) {

            #print "$year\t$prov\t$product\n";
            push @tmp, $product;
            $hpro{$year}{$prov} = [@tmp];
        }
    }
}

print Data::Dumper->Dump( [ \%hpro ] );
