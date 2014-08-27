use Mojolicious::Lite;

# Upload form in DATA section
get '/' => 'form';

# Multipart upload handler
post '/upload' => sub {
    my $self = shift;

    # Check file size
    return $self->render( text => 'File is too big.', status => 200 )
      if $self->req->is_limit_exceeded;

    # Process uploaded file
    return $self->redirect_to('form')
      unless my $example = $self->param('example');
    my $size = $example->size;
    my $name = $example->filename;
    $self->render( text => "Thanks for uploading $size byte file $name." );
};

app->start;
__DATA__

@@ form.html.ep
<!DOCTYPE html>
<html>
<head><title>Upload</title></head>
<body>
%= form_for upload => (enctype => 'multipart/form-data') => begin
%= file_field 'example'
%= submit_button 'Upload'
% end
</body>
</html>
