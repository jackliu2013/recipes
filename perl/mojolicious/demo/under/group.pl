use Mojolicious::Lite;

=comment
You can also "group" related routes,
  which allows nesting of multiple "under" statements .

=cut

# Global logic shared by all routes
under sub {
    my $self = shift;
    return 1 if $self->req->headers->header('X-Bender');
    $self->render( text => "You're not Bender." );
    return undef;
};

# Admin section
group {

    # Local logic shared only by routes in this group
    under '/admin' => sub {
        my $self = shift;
        return 1 if $self->req->headers->header('X-Awesome');
        $self->render( text => "You're not awesome enough." );
        return undef;
    };

    # GET /admin/dashboard
    get '/dashboard' => { text => 'Nothing to see here yet.' };
};

# GET /welcome
get '/welcome' => { text => 'Hi Bender.' };

app->start;
