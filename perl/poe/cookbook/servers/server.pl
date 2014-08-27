#!/usr/bin/perl
use warnings;
use strict;
use POE;
use POE::Filter::Reference;
use POE::Component::Server::TCP;
#use POE::Component::Client::TCP;

### Create a server that receives and sends Perl data structures.  It
### will be referred to by the name "sum-server" when necessary.  It
### listens on localhost port 12345.  It uses POE::Filter::Reference
### to parse input and format output.
POE::Component::Server::TCP->new(
    Alias        => "sum_server",
    Address      => "localhost",
    Port         => 12345,
    ClientFilter => "POE::Filter::Reference",

    # Handle client requests here.
    ClientInput => sub {
        my ( $heap, $list ) = @_[ HEAP, ARG0 ];
        my $sum = 0;
        my ( @odd, @even, @bad, $status );

        # Process the request into buckets for odd, even, and
        # non-integers.  Sum the integers in the request.
        if ( ref($list) eq 'ARRAY' ) {
            foreach (@$list) {
                if (/^\d+$/) {
                    if   ( $_ % 2 ) { push @odd,  $_; }
                    else            { push @even, $_; }
                    $sum += $_;
                }
                else {
                    push @bad, $_;
                }
            }
            $status = "OK";
        }
        else {
            $status = "Error: Bad request type: " . ref($list);
        }

        # Build the response hash, then send it to the client.
        my %response = (
            sum  => $sum,
            odd  => \@odd,
            even => \@even,
            bad  => \@bad,
            stat => $status,
        );
        $heap->{client}->put( \%response );
    },

    # Since this is a one-shot test program, shut down the server
    # after the first client has disconnected.  This posts "shutdown"
    # to the server itself.  Using yield() here would just shut down
    # the client connection.
    ClientDisconnected => sub {
        my $kernel = $_[KERNEL];
        $kernel->post( sum_server => "shutdown" );
    },
);

### Run both the client and server.  Yes, in the same program.
$poe_kernel->run();
