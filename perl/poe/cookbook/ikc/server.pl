
=p
This simple example demonstrates how to set up a kernel, publish a state, and then call it from an IKC client.

First, the server:
=cut

#!/usr/bin/perl -w
use strict;
use POE;
use POE::Component::IKC::Server;

POE::Component::IKC::Server->spawn(
    port => 12345,
    name => 'Server',
);

POE::Session->create(
    inline_states => {

        _start => sub {
            my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
            my $service_name = 'Incrementor';
            $kernel->alias_set($service_name);
            $heap->{num} = 0;
            $kernel->post( IKC => publish => $service_name, ['inc'] );
        },

        inc => sub {
            my ( $heap, $arg0 ) = @_[ HEAP, ARG0 ];
            print "Someone called! New value: $heap->{num}\n";

            # ARG0 is the argument passed from the client, in our case
            # an array ref.  We add the current num to the input numbers.
            my @result = ();
            for my $x (@$arg0) {
                push( @result, $x + $heap->{num}++ );
            }

            return \@result;
        },

        _stop => sub { print "Stopping $0\n"; },

    }
);

POE::Kernel->run();

