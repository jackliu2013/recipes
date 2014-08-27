
=comment
The WebSocket protocol offers full bi-directional low-latency communication
  channels between clients
  and servers
  . Receive messages just by subscribing to events such as
  "message" in Mojo::Transaction::WebSocket with the method
  "on" in Mojolicious::Controller
  and return them with "send" in Mojolicious::Controller
  .
The event "finish" in Mojo::Transaction::WebSocket will be emitted right after the WebSocket connection has been closed.
=cut

use Mojolicious::Lite;
use Mojo::IOLoop;

# Template with browser-side code
get '/' => 'index';

# WebSocket echo service
websocket '/echo' => sub {
    my $self = shift;

    # Opened
    $self->app->log->debug('WebSocket opened.');

    # Increase inactivity timeout for connection a bit
    Mojo::IOLoop->stream( $self->tx->connection )->timeout(300);

    # Incoming message
    $self->on(
        message => sub {
            my ( $self, $msg ) = @_;
            $self->send("echo: $msg");
        }
    );

    # Closed
    $self->on(
        finish => sub {
            my ( $self, $code, $reason ) = @_;
            $self->app->log->debug("WebSocket closed with status $code.");
        }
    );
};

app->start;

__DATA__
@@ index.html.ep
<!DOCTYPE html>
<html>
<head><title>Echo</title></head>
<body>
<script>
var ws = new WebSocket('<%= url_for('echo')->to_abs %>');
// Incoming messages
ws.onmessage = function(event) {
document.body.innerHTML += event.data + '<br/>';
};
// Outgoing messages
window.setInterval(function() {
ws.send('Hello Mojo!');
}, 1000);
</script>
</body>
</html>
