#!/usr/bin/perl -w
use strict;
use POE;
use POE::Component::IKC::Client;
use POE::Component::IKC::Responder;

POE::Component::IKC::Client->spawn(
    ip         => '127.0.0.1',
    port       => 12345,
    name       => "Client$$",
    on_connect => \&start_session,
);

POE::Component::IKC::Responder->spawn();

sub start_session {

    POE::Session->create(
        inline_states => {

            _start => sub {
                my ($kernel) = $_[KERNEL];
                $kernel->alias_set('IncrementorClient');
                $kernel->yield('start_ikc');
                $kernel->delay( 'kill_everyone', 5 );
            },

            start_ikc => sub {
                my ($kernel) = $_[KERNEL];

                # Call remote 'inc' with arg0 = [1,3,5]
                $kernel->post(
                    'IKC', 'call',
                    'poe://Server/Incrementor/inc',
                    [ 1, 3, 5 ],
                    'poe:get_result'
                );
            },

            get_result => sub {
                my ( $kernel, $heap, $arg ) = @_[ KERNEL, HEAP, ARG0 ];
                print "Result: [" . join( ", ", @$arg ) . "]\n";
                unless ( $heap->{shutdown} ) {
                    $kernel->post(
                        'IKC', 'call',
                        'poe://Server/Incrementor/inc',
                        [ 1, 3, 5 ],
                        'poe:get_result'
                    );
                }
            },

            kill_everyone => sub {
                my ( $kernel, $heap ) = @_[ KERNEL, HEAP ];
                $heap->{shutdown} = 1;
                $kernel->post( IKC => 'shutdown' );
            },

            _stop => sub { print "Finished...\n"; exit(0) },
        }
    );

}

POE::Kernel->run();
