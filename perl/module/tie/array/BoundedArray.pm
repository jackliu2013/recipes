package BoundedArray;

use Carp;
use strict;
use Tie::Array;
our @ISA = ("Tie::Array");

# demo
# tie (@array,"BoundedArray", 3);	# 允许的最大索引是3
#
sub TIEARRAY {
    my $class = shift;
    my $bound = shift;
    confess "usage: tie( \@ary, 'BoundedArray', max_subscript)"
      if @_ || $bound =~ /\D/;

    return bless { BOUND => $bound, DATA => [] }, $class;
}

# $self->FETCH(INDEX)
#
sub FETCH {
    my ( $self, $index ) = @_;
    if ( $index > $self->{BOUND} ) {
        confess "Array OOB: $index > $self->{BOUND} ";
    }
    return $self->{DATA}[$index];
}

# $self->STORE(INDEX,VALUE)
#
sub STORE {
    my ( $self, $index, $value ) = @_;
    if ( $index > $self->{BOUND} ) {
        confess "Array OOB: $index > $self->{BOUND}";
    }
    return $self->{DATA}[$index] = $value;
}

# FETCHSIZE 方法返回$self关联的数组的条目的总数，
# 等效于scalar(@array),通常等于$#array + 1
sub FETCHSIZE {
    my $self = shift;
    return scalar @{ $self->{DATA} };
}

sub STORESIZE {
    my ( $self, $count ) = @_;
    if ( $count > $self->{BOUND} ) {
        confess "Array OOB: $count > $self->{BOUND} ";
    }
    $self->{BOUND} = $count;
}

1;
