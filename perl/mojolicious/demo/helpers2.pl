
=comment
增加 helpers

添加和重新定义 helper 是很容易的，你可以用它们做所有的事。
=cut

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
% debug 'template';
