#!/user/bin/env perl

#
# my    定义的是词法变量
# our   定义的是全局变量
# local 定义了一个全局变量，可是你想使用一个临时变量，此时用local保存当前全局变量的值
#

#
# 此种情况下，在调用square方法的时候，改变了变量$n的值
#
#my $n = 10;

#my $square = square(15);

#print "n is $n, square is $square\n";

#sub square { $n = shift ; $n ** 2; }


#
# local 会暂时把当前的值保存起来直到local作用域结束
# 在sub square中，local会暂时把10保存起来，当square的作用域结束后
# $n的值又恢复到10
#

our $n = 10;

my $square = square(15);

print "n is $n, square is $square\n";

sub square { local $n = shift ; $n ** 2; }


