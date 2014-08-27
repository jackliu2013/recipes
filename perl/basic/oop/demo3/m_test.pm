package m_test;

my $secret_door = sub {
    my $self = shift;
    print "hello world";
};

sub knock {
    my $self = shift;
    if ( $self->{knocked}++ > 5 ) {
        $self->$secret_door();
    }
}

sub new {
    my $self = shift;
    return bless $self, "m_test";
}

1;
