=ppppppppppppppppppp
map 操作和 grep 非常类似,因为它们有相同类型的参数:
一个使用$_的块,以及一列需要处理的元素。
它们处理的方式也是类似的,首先根据列表中的元素对块的值进行判断,每一次$_被赋予新的列表中的值。
但使用块中最后一个表达式的值的方法是不同的:不是返回一个 Boolean 值,而是最终值作为返回的结果
任何的 grep 或 map 语句均可以用 foreach 循
环重新书写,每一次将结果元素放入一个临时数组中。但短的方式通常更有效以及方便。
由于 map 或 grep 的结果是列表,因此它可以直接传递给另一个函数。
=cut

#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

sub big_money {
    my $number = sprintf "%.2f", shift @_;

    #在 do-nothing 循环中,每一次加入一个逗号
    1 while $number =~ s/^(-?\d+) (\d\d\d)/$1,$2/;

    #将美元符号放入合适的位置
    $number =~ s/^(-?)/$1\$/;
    $number;
}

my @data = ( 4.75, 1.5, 2, 1234, 6.9456, 12345678.9, 29.95 );
my @formatted_data = map { &big_money($_) } @data;
print @formatted_data,"\n";


my @data = ( 4.75, 1.5, 2, 1234, 6.9456, 12345678.9, 29.95 );
print "The money numbers are:\n",
  map { sprintf( "%25s\n", &big_money($_) ) } @data;


