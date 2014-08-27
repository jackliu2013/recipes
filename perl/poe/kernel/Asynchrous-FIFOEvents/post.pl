
=p

post DESTINATION, EVENT_NAME [, PARAMETER_LIST]

post() enqueues a message to be dispatched to a particular DESTINATION session. The message will be handled by the code associated with EVENT_NAME. If a PARAMETER_LIST is included, its values will also be passed along.

post() returns a Boolean value indicating whether the message was successfully enqueued. If post() returns false, $! is set to explain the failure:

ESRCH ("No such process") - The DESTINATION session did not exist at the time post() was called.
=cut

#!/usr/bin/env perl

use strict;
use warnings;

use POE;

POE::Session->create(
    inline_states => {
        _start => sub {
            $_[KERNEL]->post( $_[SESSION], "event_name", 0 );
        },
        event_name => sub {
            print "$_[ARG0]\n";
            $_[KERNEL]->post( $_[SESSION], "event_name", $_[ARG0] + 1 )
              if ( $_[ARG0] < 10000 );
        },
    }
);

POE::Kernel->run();
exit 0;
