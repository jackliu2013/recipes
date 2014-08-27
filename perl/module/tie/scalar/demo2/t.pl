#!/usr/bin/env perl

use Tie::Counter;	# 绑定到Tie::Counter类的变量每次自增1

tie my $counter, "Tie::Counter", 100;
@array = qw /Red Green Blue/;
for my $color (@array) {

    # 打印:
    print " $counter $color\n";
}

# 100 Red
# 101 Green
# 102 Blue
