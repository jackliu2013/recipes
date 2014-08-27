#!/usr/bin/perl -w
package person;
use strict;

sub sleep() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is person, he is sleeping\n");
}

sub study() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is person, he is studying\n");
}
return 1;
