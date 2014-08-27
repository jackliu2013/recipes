package MyApp::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    my $user = $self->param('user') || '';
    my $pass = $self->param('pass') || '';
    return $self->render unless $self->users->check( $user, $pass );

    $self->session( user => $user );
    $self->flash( message => 'Thanks for logging in.' );
    $self->redirect_to('protected');
}

sub logged_in {
    my $self = shift;
    return $self->session('user') || !$self->redirect_to('index');
}

sub logout {
    my $self = shift;
    $self->session( expires => 1 );
    $self->redirect_to('index');
}

1;
