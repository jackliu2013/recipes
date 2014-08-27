package BoundedArray;
use Carp;
use strict;
use Tie::Array;
our @ISA = ("Tie::Array");

#
# TIEARRAY 返回一个bless了的引用，通过该引用模拟这个绑定了的数组。在此例子中，为了告诉我们并非一定要返回一个数组的引用，我们用一个散列引用来代表我们的对象。散列的BOUND键将存储允许的最大范围，而其“DATA”值将保存实际的数据。如果有类以外的东西试图析值返回的对象(毫无疑问认为它是一个数组引用)，将抛出一个异常。
#
sub TIEARRAY {
    my $class = shift;
    my $bound = shift;
    confess "usage: tie( \@ary, 'BoundedArray', max_index)"
        if @_ || $bound =~ /\D/;

    return bless { BOUND => $bound, DATA => [] }, $class;
}


#
#
#
sub FETCH {
    my ($self, $index) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }

    return $self->{DATA}[$index];
}


#
#
#
sub STORE {
    my ($self, $index, $value) = @_;
    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }

    return  $self->{DATA}[$index] = $value;
}

#
# 获取数组的长度
#
sub FETCHSIZE {
    my $self = shift;
    return scalar @{$self->{DATA}};
}


#
# 
#
sub STORESIZE {
    my ($self, $count) = @_;

    if ($count > $self->{BOUND}) {
        confess "Array OOB: $count > $self->{BOUND}";
    }

    $#{$self->{DATA}} = $count;
}


#
#
#
sub EXISTS {
    my ($self, $index) = @_;

    if ($index > $self->{BOUND}) {
        confess "Array OOB: $index > $self->{BOUND}";
    }

    exists $self->{DATA}[$index];
}

1;
