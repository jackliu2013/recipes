#!/usr/bin/env perl

use Time::Elapse;


use strict;
use warnings;

Time::Elapse->lapse(my $now);

sleep 10;

print "Time Wasted : $now\n";
