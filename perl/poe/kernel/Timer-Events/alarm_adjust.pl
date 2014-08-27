#!/usr/bin/env perl

use strict;
use warnings;

use POE;
use POSIX qw(strftime);
 
POE::Session->create(
  inline_states => {
    _start => sub {
      $_[HEAP]{alarm_id} = $_[KERNEL]->alarm_set(
        party => time() + 1999
      );
      $_[KERNEL]->delay(postpone => 1);
    },
    postpone => sub {
      my $new_time = $_[KERNEL]->alarm_adjust(
        $_[HEAP]{alarm_id}, -10
      );
      print(
        "Now we're gonna party like it's ",
        strftime("%F %T", gmtime($new_time)), "\n"
      );
    },
  }
);

POE::Kernel->run();

exit 0;
