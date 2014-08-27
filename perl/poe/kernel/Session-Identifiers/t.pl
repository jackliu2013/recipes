#!/usr/bin/env perl

use strict;
use warnings;

use POE;

POE::Session->create(
  inline_states => {
    _start => sub { $_[KERNEL]->alias_set("echoer") },
    ping => sub {
      $_[KERNEL]->post( $_[SENDER], "pong", @_[ARG0..$#_] );
    }
  }
);

POE::Kernel->run();

exit 0;
