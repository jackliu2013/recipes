=printf
使用 printf 格式化输出
printf有许多格式符，详细信息参见perlfunc文档
要输出数字,通常使用%g◆它将根据需要自动选用浮点数,整数,或者指数
%d 为十进制整数,根据需要而截尾:
◆%x是针对十六进制的,%o 是针对八进制的
=cut

#!/usr/bin/perl

use strict;
use warnings;

printf "in %d days!\n",17.85;	# in 17 days!

#在 Perl 中,printf 中的数据通常会接受一个宽度值。
#如果数据不能满足这个宽度,则会自动扩展开来:
printf "%06d\n",42;			#输出为 ○ ○ ○ ○ 42(○ 此处指代空格)
printf "%04d\n",2e3+1.95;	#2001

#%s 是针对字符串的,例如:
printf "%10s\n","wilma"; #输出为:     wilma
#如果宽度值为负数,则为左对齐(对于所有的格式符)

printf "%-15s\n","flintstone"; #输出为 flintstone    
#%f 根据需要进行截尾,你可以设置需要几位小数点后面的数字:
printf "%12f\n" , 6*7 + 2/3;	#   42.666667
printf "%12.3f\n" , 6*7 + 2/3;	#   42.666667
printf "%12.0f\n" , 6*7 + 2/3;	#   42.666667

###printf 数组
my @items = qw( wilma dino pebbles );
my $format = "The items are:\n". ("%10s\n" x @items);	
## x @items字符串重复次数是@items次，@items为标量上下文
## print "the format is >>$format<<\n"; #用于调试
printf $format, @items;
printf "The items are:\n". ("%10s\n" x @items), @items;
##本例中使用了@items 两次,一次在标量 context 中,取其元素的个数,
##一次在列表 context 中取其元素。context 是相当重要的。
