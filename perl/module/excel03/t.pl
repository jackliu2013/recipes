#!/usr/bin/env perl

use strict;
use warnings;
use IO::File;
use Spreadsheet::WriteExcel;

use Data::Dump;

my $fhi = IO::File->new("<in.txt");

# Create a new workbook called simple.xls and add a worksheet
my $workbook  = Spreadsheet::WriteExcel->new('simple.xls');
my $worksheet = $workbook->add_worksheet();

# The general syntax is write($row, $column, $token). Note that row and
# column are zero indexed
#
# Write some text
#$worksheet->write(0, 0,  "Hi Excel!");

my $i = 0;

while (<$fhi>) {
    my @data;
    my $j = 0;
    if (/^.+;$/) {
        @data = split ' ', $_;

        #Data::Dump->dump(@data);
        $worksheet->write( $i, $j,     $data[0] );
        $worksheet->write( $i, $j + 1, $data[1] );
        $i++;
    }
}

$fhi->close();
