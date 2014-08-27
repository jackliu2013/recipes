#!/usr/bin/perl
use warnings;
use strict;
use POE;
use POE::Filter::Reference;
use POE::Component::Server::TCP;
use POE::Component::Client::TCP;

### Create a client that sends and receives Perl data structures.
### Upon connecting with the server, it sends a list of things to
### process.  The server responds with a hash of a few things.  Upon
### receipt of that hash, the client displays its contents and exits.
POE::Component::Client::TCP->new(
    Alias         => "sum_client",
    RemoteAddress => "localhost",
    RemotePort    => 12345,
    Filter        => "POE::Filter::Reference",

    # Build a request and send it.
    Connected => sub {
        my $heap = $_[HEAP];
        my @request =
          qw( 0 2.718 3 3.1416 5 6 7 8 9 four score and seven years ago );
        $heap->{server}->put( \@request );
    },

    # Receive a response, display it, and shut down the client.
    ServerInput => sub {
        my ( $kernel, $hash ) = @_[ KERNEL, ARG0 ];
        if ( ref($hash) eq 'HASH' ) {
            print "Client received:\n";
            foreach ( sort keys %$hash ) {
                my $value = $hash->{$_};
                $value = "@$value" if ref($value) eq 'ARRAY';
                printf "\t%-4s = $value\n", $_;
            }
        }
        else {
            print "Client received an unknown response type: ", ref($hash),
              "\n";
        }
        $kernel->yield("shutdown");
    },
);
### Run both the client and server.  Yes, in the same program.
$poe_kernel->run();
