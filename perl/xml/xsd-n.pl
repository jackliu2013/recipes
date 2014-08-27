#!/usr/bin/perl
#########################################################################
# File Name: xsd.pl
# Author: hyf
# mail: houyafeng@gmail.com
# Created Time: 2014年02月17日 星期一 10时21分45秒
#########################################################################
use strict;
use warnings;
use Data::Dump;
use XML::Compile::Schema;
use XML::LibXML::Reader;
use IO::File;

my $src = IO::File->new("<0055.src");
my $rst = IO::File->new(">0055.xml");

my $xsd = '0055.xsd';
my $schema = XML::Compile::Schema->new($xsd);

# This will print a very basic description of what the schema describes
#$schema->printIndex();

# this will print a hash template that will show you how to construct a
# hash that will be used to construct a valid XML file.
#
# Note: the second argument must match the root-level element of the XML
# document.  I'm not quite sure why it's required here.

# print $schema->template('PERL', 'yspz_0055');

my $row;
my $href;
my $doc;
while(<$src>) {
    chomp;
    $row = [ split '\|' ]; 
    # Data::Dump->dump($row);
    $href->{y0055}->{serialno}  = $row->[0];
    $href->{y0055}->{txdate}    = $row->[1];
    $href->{y0055}->{c}         = $row->[2];
    $href->{y0055}->{cardtype}  = $row->[3];
    $href->{y0055}->{p}         = $row->[4];
    $href->{y0055}->{txamt}     = $row->[5];
    $href->{y0055}->{cfee}      = $row->[6];
    $href->{y0055}->{cwwscfee}  = $row->[7];
    $href->{y0055}->{bfjacctbj} = $row->[8];
    $href->{y0055}->{bi}        = $row->[9];
    $href->{y0055}->{bserialno} = $row->[10];
    $href->{y0055}->{btxdate}   = $row->[11];
    $href->{y0055}->{cleardate} = $row->[12];
    $href->{y0055}->{bfee}      = $row->[13];
    $href->{y0055}->{dealdate}  = $row->[14];
    $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    eval {
        my $write = $schema->compile( WRITER => 'yspz_0055' );
        my $xml = $write->( $doc, $href );
        $doc->setDocumentElement($xml);
    };
    if ($@) {
        # warn $@;
        next;
    }

    print $rst $doc->toString(1);    # 1 indicates "pretty print"

}

=comment
my $data = {
    y0055 => [
        {
            txdate    => "2013-12-30",
            c         => "10011427722",
            cardtype  => "1",
            p         => "15",
            txamt     => "80.00",
            cfee      => "0.00",
            cwwscfee  => "0.00",
            bfjacctbj => "1",
            bi        => "CBHB_NET_B2C_BHPX1010",
            bserialno => "2322713472",
            btxdate   => "2013-12-30",
            cleardate => "2013-12-30",
            bfee      => "1.00",
            dealdate  => "2013-12-31",
        }
    ],
};

my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
eval {
    my $write = $schema->compile( WRITER => 'yspz_0055' );
    my $xml = $write->( $doc, $data );
    $doc->setDocumentElement($xml);
};
if ($@) {
    warn $@;
}

print $doc->toString(1);    # 1 indicates "pretty print"
=cut
