use Mojolicious::Lite;

use Mojo::IOLoop;

=comment
Another primary feature of the Mojo::IOLoop event loop are timers, which can for example be used to delay rendering of a response, and unlike sleep, won't block any other requests that might be processed in parallel.
=cut

# Wait 3 seconds before rendering a response
get '/' => sub {
    my $self = shift;
    Mojo::IOLoop->timer(
        3 => sub {
            $self->render( text => 'Delayed by 3 seconds!' );
        }
    );
};

app->start;
