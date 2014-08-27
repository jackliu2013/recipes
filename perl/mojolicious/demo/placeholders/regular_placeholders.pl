use Mojolicious::Lite;

# /1
# /123
any '/:bar' => [ bar => qr/\d+/ ] => sub {
    my $self = shift;
    my $bar  = $self->param('bar');
    $self->render( text => "Our :bar placeholder matched $bar" );
};

app->start;
