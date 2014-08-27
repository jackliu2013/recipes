#!/usr/bin/env perl

use strict;
use warnings;

use POE;


POE::Session->create(
  inline_states => {
    _start => sub {
      $_[KERNEL]->delay( tick => 1, 0 );
    },
    tick => sub {
      print "tick $_[ARG0]\n";
      $_[KERNEL]->delay( tock => 1, $_[ARG0] + 1 );
    },
    tock => sub {
      print "tock $_[ARG0]\n";
      $_[KERNEL]->delay( tick => 1, $_[ARG0] + 1 );
    },
  }
);

POE::Kernel->run();

exit 0;
