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
      $_[KERNEL]->alarm_remove( delete $_[HEAP]{alarm_id} );
    },
  }
);

POE::Kernel->run();

exit 0;
