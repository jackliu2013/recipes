#!/usr/bin/perl

###############################################################################
#
# A Spreadsheet::ParseExcel utility to display an Excel file in text format.
#
# The output maintains a spreadsheet like format for easy visualisation of
# the data layout of the file. For example, a small file might be displayed
# as follows:
#       ________
#     _| Sheet1 |__________________________________________________
#    |_____________________________________________________________|
#    |         ||                |                |                |
#    |         || A              | B              | C              |
#    |_________||________________|________________|________________|
#    | 1       || Hello          | Excel          |                |
#    |_________||________________|________________|________________|
#    | 2       || 1              | 2.00           | 3.000          |
#    |_________||________________|________________|________________|
#    | 3       || 2010-01-13     |                |                |
#    |_________||________________|________________|________________|
#    | 4       || A long string *|                |                |
#    |_________||________________|________________|________________|
#    * Note: Some data truncated to fit cells.
#
# reverse('©'), January 2010, John McNamara, jmcnamara@cpan.org
#

require 5.008;
use warnings;
use strict;
use Spreadsheet::ParseExcel;

# TODO. Should add configuration options. Maybe cell merging.
# Option to display upto a certain column/row. Should use Pod::Usage also.

my $cell_width        = 14;
my $left_column_width = 7;
my $space_padding     = 2;
my $cell_padding      = $space_padding + 1;
my $data_truncated    = 0;


main();


###############################################################################
#
# main().
#
# Run the main section of the program to extract the data from the Excel
# workbook and print it out in a text table.
#
sub main {

    my $filename = $ARGV[0] or die "Parsing error: must specify filename.\n";
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse( $filename );

    binmode STDOUT, ':encoding(utf8)';

    # Check for errors from parse().
    if ( !defined $workbook ) {
        die "Parsing error: ", $parser->error(), ".\n";
    }

    # Iterate through the worksheets.
    for my $worksheet ( $workbook->worksheets() ) {

        # Track truncated data in each worksheet so we can print a warning.
        $data_truncated = 0;

        # Get the cell range for the worksheet.
        my ( $row_min, $row_max ) = $worksheet->row_range();
        my ( $col_min, $col_max ) = $worksheet->col_range();

        # Max values of -1 indicate that the worksheet doesn't contain data,
        # in which case we set the max to (0, 0) so that one cell is shown.
        $row_max = 0 if $row_max == -1;
        $col_max = 0 if $col_max == -1;

        my $column_count   = $col_max + 1;
        my $worksheet_name = $worksheet->get_name();

        # Print a dialog style tab with the sheet name.
        print_sheet_tab( $worksheet_name, $column_count );

        # Print the column headings 'A' .. 'IV'.
        print_column_headers( $column_count );

        # Iterate through the cell data and print out each row.
        for my $row ( 0 .. $row_max ) {

            # The first item of the row data is the row number.
            my @row_data = ( $row + 1 );

            for my $col ( 0 .. $col_max ) {
                my $cell = $worksheet->get_cell( $row, $col );

                # Get the formatted cell values or else store a blank string.
                if ( $cell ) {
                    push @row_data, $cell->value();
                }
                else {
                    push @row_data, '';
                }
            }

            # Print out the row data.
            print_row( \@row_data );

        }

        # Print a warning if any data was truncated to fit the cells.
        print "* Note: Some data truncated to fit cells.\n" if $data_truncated;
    }
    print "\n";
}


###############################################################################
#
# print_sheet_tab().
#
# Print a dialog style tab at the top of a  worksheet with the sheet name.
# This will look something like the following:
#    ________
#  _| Sheet1 |_________________
# |____________________________|
#
sub print_sheet_tab {

    my $sheet_name       = shift;
    my $column_count     = shift;
    my $sheet_name_width = length $sheet_name;

    my $tab_width =
      ( $cell_width + $cell_padding ) * $column_count +
      $left_column_width +
      $cell_padding;

    print "\n";
    print '   ', '_' x ( $sheet_name_width + $space_padding ), "\n";
    printf " _| %-*.*s |", $sheet_name_width, $sheet_name_width, $sheet_name;
    print '_' x ( $tab_width - $sheet_name_width - 5 ), "\n";
    print '|', '_' x $tab_width, "|\n";

}


###############################################################################
#
# print_column_headers().
#
# Print the column headers at the top of a worksheet to get an effect like the
# following. The headers are 3 lines high to distinguish them from other rows.
#  _____________________________________________________________
# |         ||                |                |                |
# |         || A              | B              | C              |
# |_________||________________|________________|________________|
#
sub print_column_headers {

    my $count   = shift;
    my $column  = 'A';
    my @headers = ( '' );

    # Store the column headers 'A' .. last.
    push @headers, $column++ for 1 .. $count;

    # Create a set of empty cells as wide as the column headers.
    my @blanks = ( '' ) x @headers;

    print_row( \@blanks, 1 );
    print_row( \@headers );
}


###############################################################################
#
# print_row().
#
# Print out a row of data with formatting. Also place the row number in the
# leftmost column to simulate the layout of a spreadsheet. Long strings are
# truncated to the width of the cell and a warning asterisk is added. The final
# effect is something like this:
#  _________  ________________ ________________ ________________
# | 1       || Hello          | Excel          |                |
# |_________||________________|________________|________________|
# | 2       || 1              | 2.00           | 3.000          |
# |_________||________________|________________|________________|
#
sub print_row {

    my $row         = shift;
    my $skip_bottom = shift;
    my @data        = @$row;
    my $row_number  = shift @data;

    # Print the left column with the row number.
    printf "| %-*s ||", $left_column_width, $row_number;

    # Print the rest of the row data.
    for my $data ( @data ) {
        my $warning = ' ';

        if ( length $data > $cell_width ) {
            $warning        = '*';
            $data_truncated = 1;
        }

        # Print the data in the cell.
        printf " %-*.*s%s|", $cell_width, $cell_width, $data, $warning;
    }

    print "\n";

    # Print the line at the bottom of a row.
    print_row_bottom( scalar @data ) unless $skip_bottom;
}


###############################################################################
#
# print_row_bottom().
#
# Print the bottom line of a row.
#
sub print_row_bottom {

    my $column_count = shift;

    # Print the left column.
    print '|', '_' x ( $left_column_width + $space_padding ), '||';

    # Print the bottom of the other cells.
    for ( 1 .. $column_count ) {
        print '_' x ( $cell_width + $space_padding ), '|';
    }
    print "\n";
}

__END__

