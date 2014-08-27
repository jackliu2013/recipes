
=comment
Helpers 也可以使用 template 块做最后的参数，比如使用它做一个标签的过滤器.
=cut

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

__END__
封装完的结果做成一个 Mojo::ByteStream 的对象，可以防止被多次转义。
