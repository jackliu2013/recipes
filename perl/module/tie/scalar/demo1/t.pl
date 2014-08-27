#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dump;

use ScalarFile;			# 装载 ScalarFile.pm

my $camel ;
my $clot ;

$clot = tie $camel, "ScalarFile", "/home/liutailin/tmp/study/perl_demo/tie/demo1/camel.lot" or die "error is:$!";

# 给绑定的变量赋值 (向绑定的文件里写入数据)
#$camel = "Hello, this is the first try for tie\n";
#$camel .= "And this is the second line,atuomatically appended.\n";

# 变量的绑定属性不会随着赋值一起传递
# my $dromedary = $camel ;		# 通过隐含接口，
								# 等价 my $dromedary = (tied $camel)->FETCH() ;
my $dromedary = $clot->FETCH();	# 同上行一样，不过是明确的方法
# print 变量$dromedary的值（$clot绑定的文件中的数据）
print $dromedary ;
#Data::Dump->dump($dromedary);

Data::Dump->dump($clot->COUNT);

$clot->DESTROY();
