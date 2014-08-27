
=p

alarm EVENT_NAME [, EPOCH_TIME [, PARAMETER_LIST] ]

alarm() clears all existing timers in the current session with the same EVENT_NAME. It then sets a new timer, named EVENT_NAME, that will fire EVENT_NAME at the current session when EPOCH_TIME has been reached. An optional PARAMETER_LIST may be passed along to the timer's handler.

Omitting the EPOCH_TIME and subsequent parameters causes alarm() to clear the EVENT_NAME timers in the current session without setting a new one.

EPOCH_TIME is the UNIX epoch time. You know, seconds since midnight, 1970-01-01. POE uses Time::HiRes::time(), which allows EPOCH_TIME to be (or include) fractional seconds.

POE supports fractional seconds, but accuracy falls off steeply after 1/100 second. Mileage will vary depending on your CPU speed and your OS time resolution.

Be sure to use Time::HiRes::time() rather than Perl's built-in time() if sub-second accuracy matters at all. The built-in time() returns floor(Time::HiRes::time()), which is nearly always some fraction of a second in the past. For example the high-resolution time might be 1200941422.89996. At that same instant, time() would be 1200941422. An alarm for time() + 0.5 would be 0.39996 seconds in the past, so it would be dispatched immediately (if not sooner).

POE's event queue is time-ordered, so a timer due before time() will be delivered ahead of other events but not before timers with even earlier due times. Therefore an alarm() with an EPOCH_TIME before time() jumps ahead of the queue.

All timers are implemented identically internally, regardless of how they are set. alarm() will therefore blithely clear timers set by other means.

alarm() returns 0 on success or a true value on failure. Usually EINVAL to signal an invalid parameter, such as an undefined EVENT_NAME.
alarm_add EVENT_NAME, EPOCH_TIME [, PARAMETER_LIST]

alarm_add() is used to add a new alarm timer named EVENT_NAME without clearing existing timers. EPOCH_TIME is a required parameter. Otherwise the semantics are identical to alarm().


=cut

#!/usr/bin/env perl

use strict;
use warnings;

use POE;

POE::Session->create(
    inline_states => {
        _start => sub {
            $_[KERNEL]->alarm( tick => time() + 1, 0 );
        },
        tick => sub {
            print "tick $_[ARG0]\n";
            $_[KERNEL]->alarm( tock => time() + 1, $_[ARG0] + 1 );
        },
        tock => sub {
            print "tock $_[ARG0]\n";
            $_[KERNEL]->alarm( tick => time() + 1, $_[ARG0] + 1 )
              if ( $_[ARG0] < 10 );
        },
    }
);

POE::Kernel->run();

exit 0;
