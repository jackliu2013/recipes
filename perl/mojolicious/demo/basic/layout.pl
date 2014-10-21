
=comment

Layouts
模板是可以分层的，你只需要选择 helper 中的 "layout" in Mojolicious::Plugin::DefaultHelpers。给当前结果放到模板中通过 "content" in Mojolicious::Plugin::DefaultHelpers.

=cut

use Mojolicious::Lite;

# /with_layout
get '/with_layout' => sub {
    my $self = shift;
    $self->render('with_layout');
};

app->start;
__DATA__

@@ with_layout.html.ep
% title 'Green';
% layout 'green';
Hello World!

@@ layouts/green.html.ep
<!DOCTYPE html>
<html>
    <head><title><%= title %></title></head>
    <body><%= content %></body>
</html>
