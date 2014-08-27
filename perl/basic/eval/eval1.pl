###############################
# Perl 提供了处理严重错误的方法:将这些代码放入 eval 块中:
# eval { $barney = $fred / $dino };
# 甚至当$dino 为 0 时,上述代码也不会让程序崩溃。eval 是一个表达式(不是像 while 或 foreach 那样的控制结构),因此结尾处的分号是必须的。
# 当执行 eval 块时发生了通常的严重错误,eval 块会停止执行,但程序不会崩溃。当 eval 结束时,你想知道它是正常结束的,还是发生了严重错误。
# 这些结果放在特殊变量$@之中。

# 如果 eval 为你捕捉了严重错误,则$@中将有程序失败的原因,可能如:
# Illegal division by zero at my_program line 12。
# 如果没有错误,则$@为空。这意味着$@是一个有用的 Boolean(true/false)
# 值(真,表示有错误),因此可能在 eval 块后看到如下的代码:
# print "An error occurred: $@" if $@;
# eval 块是真正的一个块,因此其中可以有新的局部(my)变量。
###############################
#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dump;

my ($result, $fred, $dino );

$fred = 100 ;
$dino = 0 ;

eval ( $result = $fred / $dino );

Data::Dump->dump($result);
print "An error occurred: $@" if $@ ;
