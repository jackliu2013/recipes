#!/usr/bin/env perl
use warnings;
use strict;
use POE::Component::IKC::ClientLite;

# Create an IKC client.  This also establishes a connection to an IKC
# server.  Part of the registration process is choosing a unique name
# for ourselves, which we do naively by abusing the process ID.
my $name   = "Client$$";
my $remote = create_ikc_client(
    port    => 31338,
    name    => $name,
    timeout => 10,
);
die $POE::Component::IKC::ClientLite::error unless $remote;

# We want the server to add up a list of numbers.  Using
# post_return(), we can send a detached event to the server and wait
# for its response.  The response can be delayed up to the
# create_ikc_client() timeout.  post_return() returns the value that
# was posted back to us from service_response() in the corresponding
# server example.
my @numbers = qw(8 6 7 5 3 0 9);
print "Summing   : @numbers\n";
my $return_value = $remote->post_respond( 'application/calc_sum', \@numbers );
die $POE::Component::IKC::ClientLite::error unless defined $return_value;
print "The sum is: $return_value\n";
exit 0;
