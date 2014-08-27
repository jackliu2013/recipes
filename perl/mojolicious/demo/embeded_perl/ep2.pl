use Mojolicious::Lite;

=comment
一些额外的等号可以用于禁用在 Perl 表达式中的转义的字符 <, >, &, ' 和 " 。这是默认设置，以防止XSS攻击.
<%= 'lalala' %>
<%== '<p>test</p>' %>
=cut

# /
get '/' => sub {
    my $self = shift;
    $self->render('index');
};

app->start;

__DATA__
@@index.html.ep
<% my $i = 10; %>
< ul > 
    <% for my $j (1 .. $i) { %> 
        < li > 
        <%= $j %> 
        < /li>
    <% } %>
</ ul >
