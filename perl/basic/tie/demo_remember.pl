#!/usr/bin/env perl

use strict;

use Remember;

my $fred;

my $x = tie $fred, "Remember", "camel.log";

$fred = 1;
$fred = 4;
$fred = 5;

$fred = 'hello world';

untie $fred;

system "cat camel.log";
