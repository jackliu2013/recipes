#!/usr/bin/env perl

use strict;
use warnings;

use POE;


POE::Session->create(
  inline_states => {
    _start => sub {
      $_[HEAP]{alarm_id} = $_[KERNEL]->alarm_set(
        party => time() + 1999
      );
      $_[KERNEL]->delay(raid => 1);
    },
    raid => sub {
      my ($name, $time, $param) = $_[KERNEL]->alarm_remove(
        $_[HEAP]{alarm_id}
      );
      print(
        "Removed alarm for event $name due at $time with @$param\n"
      );
 
      # Or reset it, if you'd like.  Possibly after modification.
      $_[KERNEL]->alarm_set($name, $time, @$param);
    },
  }
);

POE::Kernel->run();

exit 0;
