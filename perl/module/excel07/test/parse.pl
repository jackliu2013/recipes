#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Text::Iconv;
my $converter = Text::Iconv->new( "utf-8", 'UTF-8' );

# Text::Iconv is not really required.
# This can be any object with the convert method. Or nothing.

use Spreadsheet::XLSX;
use Excel::Writer::XLSX;
use Encode;
use Data::Dump;

my $href;
my @ckey;
my $rkey;

my $cfg = do "/home/jackliu/文档/sum/test/cfg.conf";

# write excel
my $wrbook = Excel::Writer::XLSX->new('perl.xlsx');
my $wformat = $wrbook->add_format();
$wformat->set_num_format('0.0000');

for my $file (</home/jackliu/文档/sum/test/*.xlsx>) {

    warn $file;
    if ( $file =~ /^.+\d.+$/ ) {

        my $excel = Spreadsheet::XLSX->new( $file, $converter );

        my @keys = keys %$cfg;
        Data::Dump->dump(@keys);
        foreach my $key (@keys) {
            my $sheet   = $excel->worksheet($key);
            my $wrsheet = $wrbook->add_worksheet( Encode::decode_utf8($sheet->{Name}) );
            my $minRow  = ${ $cfg->{$key}{line} }[0];
            my $maxRow  = ${ $cfg->{$key}{line} }[1];

            # warn "minRow:$minRow, maxRow:$maxRow";

            for ( my $i = $minRow ; $i <= $maxRow ; $i++ ) {
                foreach my $col ( @{ $cfg->{$key}{col} } ) {

                    # Data::Dump->dump($sheet->{Cells}[$i][$col]->{Val});
                    my $val =
                      sprintf( "%.4f", $sheet->{Cells}[$i][$col]->{Val} );

                    # warn "Row:$i, col: $col value = $val";
                    $href->{$key}{$i}{$col} += $val;

 # $href->{$key}{$i}{$col} += sprintf("%.4f", $sheet->{Cells}[$i][$col]->{Val});
                }
            }

            for ( my $i = $minRow ; $i <= $maxRow ; $i++ ) {
                foreach my $col ( @{ $cfg->{$key}{col} } ) {

                    # Data::Dump->dump($sheet->{Cells}[$i][$col]->{Val});
                    $wrsheet->write( $i, $col,$href->{$key}{$i}{$col}, $wformat );
                }
            }
        }
    }
}

$wrbook->close();

# Data::Dump->dump($href);
