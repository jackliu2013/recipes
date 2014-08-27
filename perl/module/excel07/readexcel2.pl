#!/usr/bin/perl use strict;
use warnings;
use 5.010;
use Text::Iconv;
use Data::Dump;
my $converter = Text::Iconv->new( "utf-8",'UTF-8' );

# Text::Iconv is not really required.
# This can be any object with the convert method. Or nothing.

use Spreadsheet::XLSX;
my @rows;
my @cols;
my @cols_vals;
#my @sheets_rows;
my @rows_vals;
my @sheet_name;
#my @all_xlsx = glob "*.xlsx";
my $excel = Spreadsheet::XLSX->new( '20131101_20131231_000279.xlsx', $converter );
foreach my $sheet (@{$excel->{Worksheet}}) {
 
        printf("Sheet: %s\n", $sheet->{Name});
       push @sheet_name, $sheet->{Name}; 
        unless ($sheet->{Name} eq  "表1-1（12）"){
          next; 
        }
        
        $sheet->{MaxRow} ||= $sheet->{MinRow};
        
         foreach my $row (15 .. 45) {
             push @rows,$row;
         
                $sheet->{MaxCol} ||= $sheet->{MinCol};
                my @cols;
                my @vals;
                foreach my $col ($sheet->{MinCol} ..  $sheet->{MaxCol}) {
                
                        my $cell = $sheet->{Cells} [$row] [$col];
 
                        if ($cell) {
                           # printf("( %s , %s ) => %s\n", $row, $col, $cell->{Val});
                           #print "$row, $col, $cell->{Val}","\n";
                           push  @cols,$col;  
                           push @vals,$cell->{Val};
                        }
 
                }
               my $col_val; 
               # 列与值的哈希
               @$col_val{@cols}=@vals;
           push @cols_vals,$col_val; 
        }
        my $row_val;
        @$row_val{@rows} = @cols_vals;
       push @rows_vals, $row_val;
 }
# 最终输出的结构
my $sheet_val;
 @$sheet_val{@sheet_name}=@rows_vals;
Data::Dump->dump($sheet_val);
