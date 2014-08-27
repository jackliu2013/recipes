#!/usr/bin/env perl

use IPC::Open2;
local ( *Reader, *Writer );

$pid = open2( \*Reader, \*Writer, "bc -l" );
$sum = 2;
for ( 1 .. 5 ) {
    print Writer "$sum * $sum\n";
    chomp( $sum = <Reader> );
}

close Writer;
close Reader;
waitpid( $pid, 0 );
print "sum is $sum\n";
