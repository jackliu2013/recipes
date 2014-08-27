package Critter;
#perl中类和包是等价的，类和包的名字一样时，包名就是类名

# 把一个引用和包名字标记起来的动作称作赐福(blessing), 
# 即把引用转换成一个对象的引用
sub spawn {
    my $self = {};
    bless $self, "Critter";	#把 $self 转换成Critter类对象的引用
    return $self;
}

# Critter类的一个方法
sub my_pf {
	print "hello world\n";
}
1;
