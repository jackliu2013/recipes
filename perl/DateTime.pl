#!/usr/bin/env perl

use DateTime;
use Data::Dump;

use strict;
use warnings;

my $now = DateTime->now(time_zone => 'local');

# Data::Dump->dump($now);
# Data::Dump->dump($now->hour . ":" . $now->minute .  ":" . $now->second . "." . $now->nanosecond);
Data::Dump->dump($now->nanosecond());
