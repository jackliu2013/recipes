use Mojolicious::Lite;

=comment
All placeholders require a value, but by assigning them default values you can make capturing optional.
=cut

# /hello
# /hello/Sara
get '/hello/:name' => { name => 'Sebastian' } => sub {
    my $self = shift;
    $self->render( 'groovy', format => 'txt' );
};

app->start;

__DATA__

@@ groovy.txt.ep
My name is <%= $name %>.
