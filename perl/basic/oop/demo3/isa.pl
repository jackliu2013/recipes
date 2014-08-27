#!/usr/bin/env perl
use warnings;
use strict;

use FileHandle;

if (FileHandle->isa("Exporter")) {
	print "FileHandle is an Exporter.\n";
}

my $fh = FileHandle->new();
if ($fh->isa("IO::Handle")) {
	print "\$fh is some sort of IO::Handle object.\n";
}

if ($fh->isa("GLOB")) {
	print "\$fh is really a GLOB reference.\n";
}
