#!/usr/bin/env perl

#
# demo1
#
$scalar = 'foo';
@array = 1 .. 5;

# 把标量 $scalar，数据@array 的引用分别赋值给typeglob(类型团)*foo
# 当把标量的引用赋值给typeglob(类型团)*foo时，只会影响*foo中的标量部分
# 当把数组的引用赋值给typeglob(类型团)*foo时，只会影响*foo中的数组部分
# 同理，把hash的引用赋值给typeglob，只会影响typeglob中的hash部分
#       把sub的引用赋值给typeglob，只会影响typeglob中的sub部分
# 
*foo = \$scalar;
*foo = \@array;

print "Scalar foo is $foo\n";
print "Array foo is @foo\n\n"; 

#
# 通过修改typeglob(类型团)中的标量修改原标量的引用
# 通过修改typeglob(类型团)中的数组修改原数组的引用
#

$foo = 'modify orgin value';
@foo = 6 .. 10 ;

print "Scalar foo is $foo\n";
print "Array foo is @foo\n\n";

print "\$scalar is $scalar\n";
print "\@array is @array\n";

#
# demo3 和 demo4的效果一样
#
#*units = populate();        # 把\%newhash 赋值给typeglob *units
#print $units->{kg} . "\n";    # 打印70，而不用解引用
#
#sub populate {
#    #my %newhash = (km => 10, kg => 70);
#    #return \%newhash;
#    my $newhash = {km =>10, kg => 70};
#    return \$newhash;
#}

#
# demo4
#
*units = populate();        # 把\%newhash 赋值给typeglob *units
print $units{kg} . "\n";    # 打印70，而不用解引用

sub populate {
    my %newhash = (km => 10, kg => 70);
    return \%newhash;
}


#
# demo5
#
#%units = (miles => 6, stones => 11);
#fillerup( \%units );    # 传递一个引用
#print $units{quarts};   # 打印4
#
#sub fillerup {
#    local *hashsym  = shift;    # 把\%units赋值给typeglob *hashsym
#    $hashsym{quarts} = 4;       # 影响\%units,不需要解引用
#}
