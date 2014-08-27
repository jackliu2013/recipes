#!/usr/bin/env perl 

use warnings;
use strict;

sub AUTOLOAD {
	our $AUTOLOAD ;
	warn "Attempt to call $AUTOLOAD failed.\n";
}

blarg(10);	# $AUTOLOAD will be defined main::blarg
print "Still alive!\n";
