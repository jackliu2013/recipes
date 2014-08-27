#!/usr/bin/perl

#
# substr 对字符串截取
#

use strict;
use warnings;


my @array = qw/10% 20%/;

foreach (@array) {
   my $a = substr $_,0,2;
    print "$a" . "\n";
}

my @array = qw/10G 5G/;

foreach (@array) {
   my $a = substr $_,0,2;
    print "$a" . "\n";
}

print "err". "\n" if ( "30%" ge "39%" ) ;
print "ok". "\n" if ( "10G" le "5G" ) ;
