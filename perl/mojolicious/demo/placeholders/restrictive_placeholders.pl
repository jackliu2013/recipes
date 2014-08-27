use Mojolicious::Lite;

# /test
# /123
any '/:foo' => [ foo => [qw(test 123)] ] => sub {
    my $self = shift;
    my $foo  = $self->param('foo');
    $self->render( text => "Our :foo placeholder matched $foo" );
};

app->start;
