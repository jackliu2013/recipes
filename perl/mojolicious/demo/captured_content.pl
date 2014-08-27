use Mojolicious::Lite;

get '/captured';

app->start;
__DATA__

@@ captured.html.ep
% layout 'blue', title => 'Green';
% content_for header => begin
<meta http-equiv="Pragma" content="no-cache">
% end
Hello World!
% content_for header => begin
<meta http-equiv="Expires" content="-1">
% end

@@ layouts/blue.html.ep
<!DOCTYPE html>
<html>
<head>
<title><%= title %></title>
%= content_for 'header'
</head>
<body><%= content %></body>
</html>
