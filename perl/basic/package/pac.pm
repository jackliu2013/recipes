package mypk1;

use Data::Dump;

#从一个子过程中检索一个引用,令该引用可以用做一个合适的数据类型:
*units = populate();     # 把 \%newhash 赋予类型团
print "$units{kg}\n";    # 打印 70;而不用解引用!

sub populate {
    my %newhash = ( km => 10, kg => 70 );
    return \%newhash;
}

#还可以把一个引用传递到一个引用传递到一个子过程里并且不加解引用地使用它:
%units = ( miles => 6, stones => 11 );
fillerup( \%units );     # 传递进一个引用
Data::Dump->dump( \%units );

print "$units{quarts}\n";    # 打印 4

sub fillerup {
    *hashsym = shift;     # 把 \%units 赋予该类型团
    $hashsym{quarts} = 4;    # 影响 \%units; 不需要解引用!
}

1;
