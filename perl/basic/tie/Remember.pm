package Remember;


sub TIESCALAR {
    my $class = shift;
    my $filename = shift;

    open ( my $handle, ">", $filename ) or die "Cannot open $filename: $!\n";

    print $handle, "The Start--------\n";

    bless { FH => $handle, VALUE => 0 }, $class; 
}


sub  FETCH {
    my $self = shift;
    return $self->{VALUE};
}

sub STORE {
    my ($self, $value, $handle) = @_;
    print $handle, "$value\n";
    $self->{VALUE} = $value;
}

sub DESTROY {
    my $self = shift;
    my $handle = $self->{FH};
    print $handle, "The End-----------\n";
    $handle->flush();
#    $handle->autoflush(1);
    close $handle;
}

1;
