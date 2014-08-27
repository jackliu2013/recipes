
=p
yield EVENT_NAME [, PARAMETER_LIST]

yield() is a shortcut for post() where the destination session is the same as the sender. This example is equivalent to the one for post():

As with post(), yield() returns right away, and the enqueued EVENT_NAME is dispatched later. This may be confusing if you're already familiar with threading.

yield() should always succeed, so it does not return a meaningful value.
=cut

#!/usr/bin/env perl

use strict;
use warnings;

use POE;

POE::Session->create(
    inline_states => {
        _start => sub {
            $_[KERNEL]->yield( "event_name", 0 );
        },
        event_name => sub {
            print "$_[ARG0]\n";
            $_[KERNEL]->yield( "event_name", $_[ARG0] + 1 )
              if ( $_[ARG0] < 10000 );
        },
    }
);

POE::Kernel->run();

exit 0;
