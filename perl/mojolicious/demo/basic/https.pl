use Mojolicious::Lite;

# GET /hello
get '/hellog' => sub {
    my $self = shift;
    $self->render( text => 'Hello World!' );
};

# PUT /hello
put '/hello' => sub {
    my $self = shift;
    my $size = length $self->req->body;
    $self->render( text => "You uploaded $size bytes to /hello." );
};

# GET|POST|PATCH /bye
any [qw(GET POST PATCH)] => '/bye' => sub {
    my $self = shift;
    $self->render( text => 'Bye World!' );
};

# * /whatever
any '/whatever' => sub {
    my $self   = shift;
    my $method = $self->req->method;
    $self->render( text => "You called /whatever with $method." );
};

app->start;
