#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use Data::Dump;

use IO::Socket;

# server cfg
my $cfg = {
    PeerAddr => '192.168.100.202',
    PeerPort => '11101',
    Proto    => 'tcp',
};

# create socket 
my $socket = IO::Socket::INET->new(
                PeerAddr => $cfg->{PeerAddr},
                PeerPort => $cfg->{PeerPort},
                Proto    => $cfg->{Proto}) or confess "$@,cannot create socket fd";


$socket->send("22222222\n");

$socket->close();
