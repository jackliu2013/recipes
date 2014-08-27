#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Text::Iconv;
my $converter = Text::Iconv->new( "utf-8",'UTF-8' );

# Text::Iconv is not really required.
# This can be any object with the convert method. Or nothing.

use Spreadsheet::XLSX;
use Data::Dump;

my $i = 1;
my $href;
my @ckey;
my $rkey;

my $excel = Spreadsheet::XLSX->new( '20131101_20131231_000279.xlsx', $converter );
while($i <= 1) {
 
    my $sheet = $excel->worksheet($i);
        # printf("Sheet: %s\n", $sheet->{Name});
        
        $sheet->{MaxRow} ||= $sheet->{MinRow};
        
        foreach my $row (14 .. $sheet->{MaxRow}) {
        
               $sheet->{MaxCol} ||= $sheet->{MinCol};

               if($row == 14) {
                    for( my $i = 1; $i <= $sheet->{MaxCol}; $i++) {
                        push @ckey, $sheet->{Cells}[$row][$i]->{Val};  
                    }
               }
               
               foreach my $col (0 ..  $sheet->{MaxCol}) {
                       
                       my $cell = $sheet->{Cells}[$row][$col];
 
                       # if ($cell) {
                       #     printf("( %s , %s ) => %s\n", $row, $col, $cell->{Val});
                       # }

                       if ($col == 0) {
                           $rkey = $cell->{Val};  
                       }
                       
                       $href->{$rkey}{$ckey[$col]} += $href->{$rkey}{$ckey[$col]};
                } 

        }

        $i++;
}
 
Data::Dump->dump($href);
