use Mojolicious::Lite;

# /hello.json
# /hello.txt
get '/hello' => [ format => [qw(json txt)] ] => sub {
    my $self = shift;
    return $self->render( json => { hello => 'world' } )
      if $self->stash('format') eq 'json';
    $self->render( text => 'hello world' );
};

app->start;
