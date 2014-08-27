#!/usr/bin/perl
use strict;
use warnings;
use Data::Dump;

=a 
多行注释 以=开头，=cut结尾,且=后面紧跟一个字符,=cut后面可以不用,
且=,=cut只能在行首
=cut

my %hashs = (
    "e" => 5,
    "d" => 4,
    "a" => 1,
    "b" => 2,
    "c" => 3
);

print "获取hash的所有key,返回是array:";
my @akey   = keys %hashs;
print "@akey\n";
print "获取hash的所有value,返回是array:";
my @avalue = values %hashs;
print "@avalue\n";

my $count = @akey;
print "key 的个数：$count\n";

print "hash的所有key:";
print "@akey\n";
print "hash的所有value:";
print "@avalue\n";


print "取出hash中key值a,c对应的value,返回array:";
my @tvalue = @hashs{ 'a', 'c' };
print "@tvalue\n";

print "取出hash中key值为a的value:";
my $tvalue = $hashs{b};
print "$tvalue\n";

print "eahc函数迭代hash,但是each返回的key/value对，顺序错乱\n";
while ( my ( $key, $value ) = each %hashs ) {
    print "$key => $value\n";
}

############foreach############
print "利用sort和foreach对hash进行排序\n";
foreach my $key ( sort keys %hashs ) {
    my $value = $hashs{$key};
    print "$key => $value\n";
}

##############exists#################
print "利用exists函数检测某个key在hash中是否存在\n";
if ( exists $hashs{a} ) {
    print "Hey,there is key a in hashs\n";
    $hashs{"a"} += 3;
    Data::Dump->dump(%hashs);
}

###############delete##################
print "利用delete函数从hash中将指定的key及其对应的value删除\n";
print "before delete:", Data::Dump->dump( \%hashs ) . "\n";

delete $hashs{"d"};
print "after delete:", Data::Dump->dump( \%hashs ) . "\n";

############向hash里添加#########
print "向hash里添加key/value对:";
print "before add:", Data::Dump->dump( \%hashs ) . "\n";
$hashs{f} = '10';
print "after add:", Data::Dump->dump( \%hashs ) . "\n";

##########hash转换成array##########
print "hash转换成数组:";
my @arr = (%hashs);
print "hash turn to array:";
print "@arr\n";

########hash reverse###################
# 原来的key当作value，原来的value当key
print "对hash进行反向:";
my %test = reverse %hashs;
print "before hash reverse:" . Data::Dump->dump(%hashs) . "\n";
print "after hash reverse:" . Data::Dump->dump(%test) . "\n";

########## array turn into hash ###########
print "数组转换成hash";
my @arr2 = qw/a 10 b 11 c 12/;
printf "array turn into hash:";
my %atoh = @arr2;
Data::Dump->dump( \%atoh ) . "\n";
