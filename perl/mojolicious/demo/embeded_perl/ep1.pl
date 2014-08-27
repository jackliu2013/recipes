use Mojolicious::Lite;

# 使用 <% 的 Tag 和使用 % 的行是一样的，但是根据不同的上下文时不同的内容看起来会好些。分号会自动追加到所有的表达式。

# /
get '/' => sub {
    my $self = shift;
    # 用index.html.ep 来进行渲染
    # $self->render('index');

    # 用inline模版来进行渲染
    $self->render(inline =>'The result is <%=1+1%>');
};

app->start;

__DATA__
@@index.html.ep
% my $i = 8; 
< ul > 
    % for my $j (1 .. $i) {
        < li > 
        %= $j
        < /li>
    % } 
</ ul >
