#!/usr/bin/perl -w
package dog;
use strict;

sub sleep() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is dog, he is sleeping\n");
}

sub bark() {
    my ($self) = @_;
    my $name = $self->{"name"};
    print("$name is dog, he is barking\n");
}
return 1;
