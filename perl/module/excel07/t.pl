#!/usr/bin/env perl

# use Spreadsheet::Read;
use Spreadsheet::ParseXLSX;
use Spreadsheet::ParseExcel;
use Data::Dump;

use strict;
use warnings;


    my $parser   = Spreadsheet::ParseXLSX->new();
    my $workbook = $parser->parse('Book1.xlsx');

    if ( !defined $workbook ) {
        warn "parse error";
        die $parser->error(), ".\n";
    }

   #  for my $worksheet ( $workbook->worksheets(0) ) {
        my $worksheet = $workbook->worksheet(0);

         my ( $row_min, $row_max ) = $worksheet->row_range();
         my ( $col_min, $col_max ) = $worksheet->col_range();
         Data::Dump->dump("row_min : $row_min, row_max : $row_max");
         Data::Dump->dump("col_min : $col_min, col_max : $col_max");

        my $name = $worksheet->get_name();
        warn "$name";
        my $row = 1;
        my $col = 1;
        my $cell = $worksheet->get_cell($row , $col);
        # Data::Dump->dump($cell);
        warn $cell->value . "\n" ;
        # Data::Dump->dump($name);
        # for my $row ( $row_min .. $row_max ) {
        #     for my $col ( $col_min .. $col_max ) {

        #         my $cell = $worksheet->get_cell( $row, $col );
        #         next unless $cell;

        #         print "Row, Col    = ($row, $col)\n";
        #         print "Value       = ", $cell->value(),       "\n";
        #         print "Unformatted = ", $cell->unformatted(), "\n";
        #         print "\n";
        #     }
        #  } 
   #  }
