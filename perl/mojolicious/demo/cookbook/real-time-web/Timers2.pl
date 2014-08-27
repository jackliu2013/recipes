
=comment
Recurring timers are slightly more powerful, but need to be stopped manually, or they would just keep getting emitted.
=cut

use Mojolicious::Lite;
use Mojo::IOLoop;

# Count to 5 in 1 second steps
get '/' => sub {
    my $self = shift;

    # Start recurring timer
    my $i  = 1;
    my $id = Mojo::IOLoop->recurring(
        1 => sub {
            $self->write_chunk($i);
            $self->finish if $i++ == 5;
        }
    );

    # Stop recurring timer
    $self->on( finish => sub { Mojo::IOLoop->remove($id) } );
};

app->start;
