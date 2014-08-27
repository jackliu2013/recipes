#!/usr/bin/env perl
use strict;
use warnings;

my $pid;
open( INPUT, " < /etc/passwd" ) or die "Can't read /etc/passwd: $!";

if ( $pid = fork ) { wait }		#父进程
else {
	# 子进程
    defined($pid) or die "fork: $!";
    open( STDIN, "<&INPUT" ) or die "dup: $!";
    exec( "cat", "-n" ) or die "exec cat: $!";
}
