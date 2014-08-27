package Tie::Counter;

# 绑定到此类的变量每次自增1
#
sub FETCH { ++${ $_[0] } }
sub STORE { ${ $_[0] } = $_[1] }

sub TIESCALAR {
    my ( $class, $value ) = @_;
    $value = 0 unless defined $value;
    bless \$value => $class;
}

1;    # 如果在模块里需要这个
