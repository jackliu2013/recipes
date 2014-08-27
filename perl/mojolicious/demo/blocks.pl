
=comment
Blocks
模板可以使用标准的 Perl 的功能，只需要使用 begin 和 end 的关键字分隔.
=cut

use Mojolicious::Lite;

# /with_block
get '/with_block' => 'block';

app->start;
__DATA__

@@ block.html.ep
% my $link = begin
    % my ($url, $name) = @_;
    Try <%= link_to $url => begin %><%= $name %><% end %>.
% end

<!DOCTYPE html>
<html>
<head><title>Sebastians frameworks</title></head>
<body>
     %= $link->('http://mojolicio.us', 'Mojolicious')
     %= $link->('http://catalystframework.org', 'Catalyst')
</body>
</html>                        
