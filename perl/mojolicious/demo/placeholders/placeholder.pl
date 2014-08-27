
=comment
占位符
路径选择的占位符可以让你取得一些请求中的路径。结果会可以通过 "stash" in Mojolicious::Controller 和 "param" in Mojolicious::Controller 来访问.
=cut

use Mojolicious::Lite;

# 占位符:bar 匹配/foo/test中的test  匹配/foo/test123中的test123
# /foo/test
# /foo/test123
get '/foo/:bar' => sub {
    my $self = shift;
    my $bar  = $self->stash('bar');
    $self->render( text => "Our :bar placeholder matched $bar" );
};

# 占位符:bar 匹配/testsomething/foo中的test 
#            匹配/test123something/foo中的test123
# /testsomething/foo
# /test123something/foo
get '/(:bar)something/foo' => sub {
    my $self = shift;
    my $bar  = $self->param('bar');
    $self->render( text => "Our :bar placeholder matched $bar" );
};

app->start;
