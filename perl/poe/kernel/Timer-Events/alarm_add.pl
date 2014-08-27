=p
A program may use alarm_add() without first using alarm().

alarm_add() returns 0 on success or EINVAL if EVENT_NAME or EPOCH_TIME is undefined.

=cut

#!/usr/bin/env perl

use strict;
use warnings;

use POE;

POE::Session->create(
  inline_states => {
    _start => sub {
      $_[KERNEL]->alarm_add( tick => time() + 1.0, 1_000_000 );
      $_[KERNEL]->alarm_add( tick => time() + 1.5, 2_000_000 );
    },
    tick => sub {
      print "tick $_[ARG0]\n";
      $_[KERNEL]->alarm_add( tock => time() + 1, $_[ARG0] + 1 );
    },
    tock => sub {
      print "tock $_[ARG0]\n";
      $_[KERNEL]->alarm_add( tick => time() + 1, $_[ARG0] + 1 );
    },
  }
);

POE::Kernel->run();

exit 0;
