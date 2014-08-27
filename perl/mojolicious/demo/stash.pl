#!/usr/bin/env perl
use Mojolicious::Lite;

=p
"stash" in Mojolicious::Controller 是用来传一些数据给模板技术使用,在这我们使用的是 DATA 这个部分的模板
=cut

# /bar
get '/bar' => sub {
    my $self = shift;
    $self->stash( one => 23 );
    $self->render( 'baz', two => 24 );
};

app->start;
__DATA__

@@ baz.html.ep
The magic numbers are <%= $one %> and <%= $two %>.
