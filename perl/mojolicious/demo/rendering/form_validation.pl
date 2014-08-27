use Mojolicious::Lite;

=comment
validation 方法cannot be founded
=cut

get '/' => sub {
    my $self = shift;

    # Check if parameters have been submitted
    my $validation = $self->validation;
    return $self->render unless $validation->has_data;

    # Validate parameters ("pass_again" depends on "pass")
    $validation->required('user')->size( 1, 20 )->like(qr/^[e-t]+$/);
    $validation->required('pass_again')->equal_to('pass')
      if $validation->optional('pass')->size( 7, 500 )->is_valid;

    # Render confirmation if validation was successful
    $self->render('thanks') unless $validation->has_error;
} => 'index';

app->start;

__DATA__
@@ index.html.ep
<!DOCTYPE html>
<html>
<head>
%= stylesheet begin
label.field-with-error { color: #dd7e5e }
input.field-with-error { background-color: #fd9e7e }
% end
</head>
<body>
%= form_for index => begin
%= label_for user => 'Username (required, 1-20 characters, only e-t)'
<br>
%= text_field 'user'
%= submit_button
<br>
%= label_for pass => 'Password (optional, 7-500 characters)'
<br>
%= password_field 'pass'
<br>
%= label_for pass_again => 'Password again (equal to the value above)'
<br>
%= password_field 'pass_again'
% end
</body>
</html>

@@ thanks.html.ep
<!DOCTYPE html>
<html><body>Thank you <%= validation->param('user') %>.</body></html>
