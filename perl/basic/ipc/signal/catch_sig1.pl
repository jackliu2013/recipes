#!/usr/bin/evn perl

use Carp;
use POSIX;


our $shucks;

sub catch_zap {
    my $signame = shift;
    $shucks++;
    die "Somebody sent me a SIG$signame";
}
$SIG{INT} = \&catch_zap;                   # best strategy

while(1) {
    pause();
}
