#!/usr/bin/env perl

open STATUS, "-|","netstat", "-an"
	or die "can't run netstat: $!";

print grep { !/^(tcp|udp)/ } `netstat -an 2>&1`;
	die "bad netstat" if $? ;
