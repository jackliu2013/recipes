#!/usr/bin/env perl

use strict;
use warnings;
use DateTime;


my $dt = DateTime->new(
    year      => 2000,
    month     => 5,
    day       => 10,
    hour      => 15,
    minute    => 15,
    time_zone => 'America/Los_Angeles',
);

print $dt->hour . "\n" ;    # prints 15

$dt->set_time_zone('America/Chicago');

print $dt->hour . "\n" ;    # prints 17



$dt->set_time_zone('local');

print $dt->hour . "\n" ;    # prints 17
