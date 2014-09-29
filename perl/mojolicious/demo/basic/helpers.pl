
=comment
Helpers

你可以扩展内置的 Mojolicious 的这个 helpers, 全部内置的所有的原生的可以在 Mojolicious::Plugin::DefaultHelpers 和 Mojolicious::Plugin::TagHelpers 中来查看.
=cut

use Mojolicious::Lite;

# "whois" helper
helper whois => sub {
    my $self  = shift;
    my $agent = $self->req->headers->user_agent || 'Anonymous';
    my $ip    = $self->tx->remote_address;
    return "$agent ($ip)";
};

# /secret
get '/secret' => sub {
    my $self = shift;
    my $user = $self->whois;
    $self->app->log->debug("Request from $user.");
};

app->start;

__DATA__
@@ secret.html.ep
We know who you are <%= whois %>.
