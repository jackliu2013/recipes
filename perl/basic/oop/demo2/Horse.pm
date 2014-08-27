package Horse;


# Horse类的new初始化构造器 
sub new {
    my $invocant = shift;
    my $class    = ref($invocant) || $invocant;
    my $self     = {
        color => "bay",		#color属性默认为bay
        legs  => 4,			#legs属性默认为4
        owner => undef,		#owner属性默认为undef
        @_,    #覆盖以前的属性	#当传入属性的值时，覆盖上述三个属性的值
    };
    return bless $self, $class;
}

1;
