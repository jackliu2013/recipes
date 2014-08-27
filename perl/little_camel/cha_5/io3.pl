=call args
调用参数,技术上<>从@ARGV中得到调用参数。这个数组是PERL中的一个特殊数组，
其包含调用参数的列表，程序开始运行时，调用参数已被保存在@ARGV之中了
=cut

#!/usr/bin/perl

use strict;
use warnings;

print "@ARGV\n";
while(<>){
	chomp;
	print "It was $_\n";
}
