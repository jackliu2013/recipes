
=p
This example contains a trivial application server using POE::Component::IKC, and a corresponding client using POE::Component::IKC::ClientLite.

IKC stands for "Inter-Kernel Communication" and is used to pass events between POE processes. The ClientLite library allows non-POE programs to interact with POE-based services.

In this example, the server adds up a list of number and returns their sum. The client sends such a list and prints the result.

  Summing   : 8 6 7 5 3 0 9
  The sum is: 38

Here is the server. As usual, the comments make it look longer than it actually is. 

=cut

#!/usr/bin/env perl
use warnings;
use strict;
use lib qw(blib/lib blib/arch);
use POE qw(Session);
use POE::Component::IKC::Server;
use POE::Component::IKC::Specifier;

# Create an IKC server.  It runs as a separate session, and does
# message passing for us.
POE::Component::IKC::Server->spawn(
    port => 31338,
    name => 'AppServer',
);

# Create a session that will be accessible through an IKC network.
POE::Session->create(
    inline_states => {
        _start        => \&service_start,
        calc_sum      => \&service_calc_sum,
        did_something => \&service_response,
    }
);

# Run, server, run!
POE::Kernel->run();
exit 0;

# Start the service.  Set up an alias, which is our service's name.
# Call IKC to publish the service and some public events.
sub service_start {
    my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
    my $service_name = "application";
    $kernel->alias_set($service_name);
    $kernel->call( IKC => publish => $service_name, ["calc_sum"] );
}

# Calculate the sum of the numbers in a list.  We only perform minimal
# data validation here, which may be a hazard in a real application.
#
# This service is intended for use with PoCo::IKC::ClientLite's
# post_respond() method.  Therefore ARG0 is special: the data given to
# us is in element 0, and an RSVP identifier is in element 1.  Posting
# the response to the RSVP identifier will send it back to the
# requester.
#
# However, we don't send the sum back right away.  Instead, we delay a
# little bit to show how you can pass data through the usual POE event
# handlers before sending it back.
sub service_calc_sum {
    my ( $kernel, $heap, $request ) = @_[ KERNEL, HEAP, ARG0 ];
    my ( $data, $rsvp ) = @$request;
    my $sum = 0;
    if ( ref($data) eq "ARRAY" ) {
        $sum += $_ foreach @$data;
    }
    $kernel->delay_set( did_something => 1, $rsvp, $sum );
}

# After a little time, send the response back.  We post the response
# to the RSVP identifier.  IKC matches it up to the client internally.
sub service_response {
    my ( $kernel, $heap, $rsvp, $sum ) = @_[ KERNEL, HEAP, ARG0, ARG1 ];
    $kernel->call( IKC => post => $rsvp, $sum );
}
