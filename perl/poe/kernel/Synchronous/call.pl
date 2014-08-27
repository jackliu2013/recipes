#!/usr/bin/env perl

use strict;
use warnings;

use POE;


POE::Session->create(
  inline_states => {
    _start => sub {
      print "Got: ", $_[KERNEL]->call($_[SESSION], "do_now"), "\n";
    },
    do_now => sub {
      return "some value";
    }
  }
);

POE::Kernel->run();
exit 0;
