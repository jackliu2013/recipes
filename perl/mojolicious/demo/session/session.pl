use Mojolicious::Lite;

# Access session data in action and template
get '/counter' => sub {
    my $self = shift;
    $self->session->{counter}++;
};

app->start;
__DATA__

@@ counter.html.ep
Counter: <%= session 'counter' %>
