#
# 闭合域同时用于生成对象本身和生成指示器
#
package Person;

sub new {
    my $invocant = shift;
    my $class    = ref($invocant) || $invocant;
    my $data     = {
        NAME    => "unnamed",
        RACE    => "unknown",
        ALIASES => [],
    };
    my $self = sub {
        my $field = shift;
###############################
### 在这里进行访问检查
###
###############################
        if (@_) { $data->{$field} = shift }
        return $data->{$field};
    };
    bless( $self, $class );
    return $self;
}

# 生成方法名
for my $field (qw(name race aliases)) {
    no strict "refs";

    # 为了访问符号表
    *$field = sub {
        my $self = shift;
        return $self->( uc $field, @_ );
    };
}

1;
