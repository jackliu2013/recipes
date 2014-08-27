#!/usr/bin/perl

###############################################################################
#
# A simple Spreadsheet::ParseExcel Excel parser.
#
# reverse('©'), January 2010, John McNamara, jmcnamara@cpan.org
#

use warnings;
use strict;
use Spreadsheet::ParseExcel;

my $filename = $ARGV[0] or die "Must specify filename to parse.\n";
my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse( $filename );

if ( !defined $workbook ) {
    die "Parsing error: ", $parser->error(), ".\n";
}

for my $worksheet ( $workbook->worksheets() ) {

    print "Worksheet name: ", $worksheet->get_name(), "\n\n";

    my ( $row_min, $row_max ) = $worksheet->row_range();
    my ( $col_min, $col_max ) = $worksheet->col_range();

    for my $row ( $row_min .. $row_max ) {
        for my $col ( $col_min .. $col_max ) {

            my $cell = $worksheet->get_cell( $row, $col );
            next unless $cell;

            print "    Row, Col    = ($row, $col)\n";
            print "    Value       = ", $cell->value(),       "\n";
            print "    Unformatted = ", $cell->unformatted(), "\n";
            print "\n";
        }
    }
}

__END__
