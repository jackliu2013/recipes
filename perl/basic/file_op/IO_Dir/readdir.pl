#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use Data::Dump;

opendir( DIR, "." ) || confess "open current directory error";

my @fls = readdir DIR;

#
#Data::Dump->dump( @fls );

my $file;
foreach $file (@fls) {
    if ( $file =~ /^[a-z]+\.pl/ ) {
        printf( "%s\n", $file );
    }
}

close(DIR);
