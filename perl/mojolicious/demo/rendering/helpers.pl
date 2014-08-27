use Mojolicious::Lite;

helper debug => sub {
    my ( $self, $string ) = @_;
    $self->app->log->debug($string);
};

get '/' => sub {
    my $self = shift;
    $self->debug('action');
} => 'index';

app->start;
__DATA__
@@ index.html.ep
% debug 'this is test template';
