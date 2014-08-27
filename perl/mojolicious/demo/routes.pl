use Mojolicious::Lite;

=comment
Route names
全部的 Routes 会关联到相关的名字，会自动的取得相关的名字的模板。另外 "url_for" in Mojolicious::Controller 和 "link_to" in Mojolicious::Plugin::TagHelpers 也能帮到你。
=cut

# /
get '/' => sub {
    my $self = shift;
    $self->render;
  } => 'index';

# /hello
get '/hello';

app->start;
__DATA__

@@ index.html.ep
<%= link_to Hello  => 'hello' %>.
<%= link_to Reload => 'index' %>.

@@ hello.html.ep
Hello World!
