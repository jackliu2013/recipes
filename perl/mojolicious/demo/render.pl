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
    $self->render(text => "$dividend / $divisor");
};

app->start;

__END__
当除数为0时，调用render_exception 报500错误
当除数，被除数不是数字时，报404错误
