#!/usr/bin/env perl

open STATUS, "netstat -an 2>/dev/null |"
	or die "can't fork: $!";

while (<STATUS>) {
	next if /^(tcp|udpP)/ ;		# tcp or udp 打头的，则next
	print ;
}
close STATUS or die "bad netstat : $! $?";
