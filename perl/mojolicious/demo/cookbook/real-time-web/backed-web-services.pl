use Mojolicious::Lite;

=comment
Since Mojo::UserAgent is also based on the Mojo::IOLoop event loop, it won't block the built-in web servers when used non-blocking, even for high latency backend web services.
=cut

# Search MetaCPAN for "mojolicious"
get '/' => sub {
    my $self = shift;
    $self->ua->get(
        'api.metacpan.org/v0/module/_search?q=mojolicious' => sub {
            my ( $ua, $tx ) = @_;
            $self->render( 'metacpan', hits => $tx->res->json->{hits}{hits} );
        }
    );
};

app->start;

__DATA__
@@ metacpan.html.ep
<!DOCTYPE html>
<html>
<head><title>MetaCPAN results for "mojolicious"</title></head>
<body>
% for my $hit (@$hits) {
<p><%= $hit->{_source}{release} %></p>
% }
</body>
</html>
