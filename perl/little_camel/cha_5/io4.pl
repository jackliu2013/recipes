=output 
输出到标准输出设备

print 操作将传给它的依次输出到标准输出设备中,一个接着一个。不会在这些元素之前,之后,或之中加入任何字符
◆	如果想在其间加入空格,在结尾加入换行符,那需具体指定它:
◆	默认情况下,不会加入任何的字符,但这种默认行为(就像 Perl 中别的 default 一样)是可以改变的。改变这种
默认值,可能影响你的维护人员,因此应当尽量避免它,除非在一些小的,quick-and-dirty 程序,或者程序的一小段中。
参看 perlvar 的帮助手册,学习改变这种默 认值的方法 
=cut

#!/usr/bin/perl

use strict;
use warnings;

my $name = "Larry Wall";
print	"Hello there, $name , did you know that 3+4 is ", 3+4, "?\n";

my @array = qw/hello this is array test/;
print @array;	#打印出元素的列表
print "@array";	#打印一个字符串（包含一个内插的数组）

=tell
第一个语句打印出所有的元素,一个接着一个,其中没有空格。
第二个打印出一个元素,它为@array 的所有元素,其被存在一个字符串中。
也就是说,打印出@array 的所有元素,并由空格分开
◆如果@array 包含 qw /fred barney betty /◆,则
第一个例子输出为:fredbarneybetty,而第二个例子输出为 fred barney betty(由空格分开)
◆是的,空格也为默认值。参见 perlval
Perl 在内插数组时,它会在元素之间加入空格。
=cut
