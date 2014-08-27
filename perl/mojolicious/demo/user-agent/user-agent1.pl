use Mojolicious::Lite;

# Blocking
get '/headers' => sub {
    my $self = shift;
    my $url  = $self->param('url') || 'http://mojolicio.us';
    my $dom  = $self->ua->get($url)->res->dom;
    $self->render( json => [ $dom->find('h1, h2, h3')->text->each ] );
};

# Non-blocking
get '/title' => sub {
    my $self = shift;
    $self->ua->get(
        'mojolicio.us' => sub {
            my ( $ua, $tx ) = @_;
            $self->render( data => $tx->res->dom->at('title')->text );
        }
    );
};

# Parallel non-blocking
get '/titles' => sub {
    my $self  = shift;
    my $delay = Mojo::IOLoop->delay(
        sub {
            my ( $delay, @titles ) = @_;
            $self->render( json => \@titles );
        }
    );
    for my $url ( 'http://mojolicio.us', 'https://metacpan.org' ) {
        my $end = $delay->begin(0);
        $self->ua->get(
            $url => sub {
                my ( $ua, $tx ) = @_;
                $end->( $tx->res->dom->html->head->title->text );
            }
        );
    }
};

app->start;
