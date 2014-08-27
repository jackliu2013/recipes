use Mojolicious::Lite;

plugin 'DebugHelper';

get '/' => sub {
    my $self = shift;
    $self->debug('It works.');
    $self->render('Hello');
};

app->start;

__DATA__
@@ Hello.html.ep
<!DOCTYPE html>
<html><body>Thank you. this is plugin test </body></html>
