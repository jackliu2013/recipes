use Mojolicious::Lite;
use Mojo::ByteStream;

helper trim_newline => sub {
    my ( $self, $block ) = @_;
    my $result = $block->();
    $result =~ s/\n//g;
    return Mojo::ByteStream->new($result);
};

get '/' => 'index';

app->start;

__DATA__
@@ index.html.ep
%= trim_newline begin
Some text.
%= 1 + 1
More text.
% end
