use Mojolicious::Lite;

=comment
HTTP
"req" in Mojolicious::Controller 和 "res" in Mojolicious::Controller 提供了全功能的 HTTP 的支持.
=cut

# /agent
get '/agent' => sub {
    my $self = shift;
    $self->res->headers->header( 'X-Bender' => 'Bite my shiny metal ass!' );
    $self->render( text => $self->req->headers->user_agent );
};

app->start;
