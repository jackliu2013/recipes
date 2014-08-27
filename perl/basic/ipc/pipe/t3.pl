#!/usr/bin/env perl

open FH, "| cat 1>aa 2>&1"
  or die "can't fork: $!";
local $SIG{PIPE} = sub { die "spooler pipe broke" };
print FH "stuff\n";
close FH or die "bad spool: $! $?";
