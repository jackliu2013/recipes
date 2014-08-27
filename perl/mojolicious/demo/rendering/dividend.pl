use Mojolicious::Lite;
use Scalar::Util 'looks_like_number';

get '/divide/:dividend/by/:divisor' => sub {
    my $self = shift;
    my ( $dividend, $divisor ) = $self->param( [ 'dividend', 'divisor' ] );

    # 404
    return $self->render_not_found
      unless looks_like_number $dividend && looks_like_number $divisor;

    # 500
    return $self->render_exception('Division by zero!') if $divisor == 0;

    # 200
    $self->render( text => $dividend / $divisor );
};

app->start;

__DATA__
@@ exception.production.html.ep 
<!DOCTYPE html> 
<html> 
<head>
<title>Server error</title>
</head>
<body>
<h1>Exception</h1> 
<p> <%= $exception->message %> </p> 
<h1> Stash </h1> 
<pre><%= dumper $snapshot %> </pre>
</body > 
</html>
