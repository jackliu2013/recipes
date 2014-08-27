#!/usr/bin/env perl

=comment
FTP上传的流水有些数据字段是空的，但是在流水导入的时候，不能

=cut

use strict;
use warnings;
use IO::File;

my $rfh1 = IO::File->new("<0055.src");
my $rfh2 = IO::File->new("<0055_check.fail");
my $wfh  = IO::File->new(">0055.tmp");


while(<$rfh2>) {
    chomp;
    my $line2 = $_; 
    while(<$rfh1>) {
        chomp;
        my $line1 = $_;
        my $row = [ split '\|', $line1 ];
        
        if ($line1 =~ /$line2/) {
            $row->[0] = $row->[0] || 99;
            $row->[1] = $row->[1] || $row->[11] || $row->[12];
            $row->[2] = $row->[2] || 'a';
            $row->[4] = $row->[4] || 15;
            $line1 = join '|', @$row;
            $wfh->print("$line1\n"); 
        }
        else {
           $wfh->print("$line1\n"); 
        }

    }

}

$wfh->close();
$rfh2->close();
$rfh1->close();

