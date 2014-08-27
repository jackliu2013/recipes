use Mojolicious::Lite;

=comment
Formats can be automatically detected by looking at file extensions.
=cut

# /detection.html
# /detection.txt
get '/detection' => sub {
    my $self = shift;
    $self->render('detected');
};

app->start;
__DATA__

@@ detected.html.ep
<!DOCTYPE html>
<html>
    <head><title>Detected</title></head>
    <body>HTML was detected.</body>
</html>

@@ detected.txt.ep
TXT was detected.
