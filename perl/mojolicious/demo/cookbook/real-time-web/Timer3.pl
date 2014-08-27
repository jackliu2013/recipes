
=comment
Timers are not tied to a specific request or connection, and can even be created at startup time.
=cut

use Mojolicious::Lite;
use Mojo::IOLoop;

# Count seconds since startup
my $i = 0;
Mojo::IOLoop->recurring( 1 => sub { $i++ } );

# Show counter
get '/' => sub {
    my $self = shift;
    $self->render( text => "About $i seconds running!" );
};

app->start;
