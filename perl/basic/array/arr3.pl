#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

warn "--------------------------1";
my @str1 = qw/hello world baby/;
print "数组是[@str1]\n";
print "数组元素0：[$str1[0]]\n";
print "数组元素1：[$str1[1]]\n";
print "数组元素2：[$str1[2]]\n";

warn "--------------------------2";

# 数组元素个数
print
"把数组赋值给一个标量，得到的是一个数组的元素的个数\n";
my $str1_count = @str1;
print "数组元素个数:$str1_count\n";
print "数组最大的索引:$#str1\n";

warn "--------------------------3";
warn "把数组引用赋值给一个引用变量";
my $aref = \@str1;

warn "通过数组引用访问数组:[@$aref]";
print "元素0：$aref->[0]\n";
print "元素1：$aref->[1]\n";
print "元素2：$aref->[2]\n";

print "通过数组引用访问数组:[$aref]\n";
print "数组：" . Data::Dump->dump($aref) . "\n";
my $tref = $aref;
print "通过数组引用访问数组:[$tref]\n";
print "通过引用访问数组：" . Data::Dump->dump($tref) . "\n";

#my $select_output="my_output";
#open LOG, "$select_output";

=ppppppppppppppppppppppppp

##################数组存取############
#对Perl数组中的值通过下标存取，第一个元素下标为0。
#试图访问不存在的Perl数组元素，则结果为NULL，但
#如果给超出Perl数组大小的元素赋值，则Perl数组自动增长
#原来没有的元素值为NULL
warn "------------------4";
my @array=(1,2,3,4);
my $scalar=$array[0];

print $scalar,"\n";
$array[3]=5;	            #now @array is (1,2,3,5)

$scalar=$array[4];	        #now	$scalar=null;
print $scalar,"\n";

$scalar=$array[6]=8;	    #now	@array	is(1,2,3,5,"","",17)
print $scalar,"\n";


#################数组间拷贝,数组直接赋值#######
warn "------------------5";
my @tmp=@array;
print @tmp,"\n";

##################################
##Perl数组对简单变量的赋值
warn "------------------6";
my ($var1,$var2,$var3);
@array=(5,7,11);
($var1, $var2)=@array;      #$var1=5,$var2=7,11被忽略
#print $var1,$var2,"\n";    #等价与print ($var1,$var2,"\n"); 
print "$var1$var2\n";       #也等价与print "$var1$var2\n";
@array=(6,8);
($var1,$var2,$var3)=@array; #$var1=5,$var2=7,$var3=""(null)
print $var1,$var2,$var3,"\n";


##################################################################
#列表/Perl数组的长度
#当Perl数组变量出现在预期简单变量出现的地方，则PERL解释器取其长度。
##################################################################
warn "------------------7";
@array=(1,2,3);
$scalar=@array;		#$scalar=3,即@array的长度
print "$scalar\n";
($scalar)=@array;	#$scalar=1,即@array第一个元素的值
print "$scalar\n";
                    #注：以Perl数组的长度为循环次数可如下编程：
my $count=1;
while($count <= @array){
	print("element$count:$array[$count-1]\n");
	$count++;
}


###################################
#子数组
##################################
warn "------------------7";
@array=(1,2,3,4,5);
print "@array\n";

my @subarray=@array[0,1];       #@subarray=(1,2)
print "@subarray\n";

my @subarray2=@array[1..3];     #@subarray2=(2,3,4)  @array[1..3]是数组的slice
print "@subarray2\n";

@array[0,1]=("string",46);      #@array=("string",46,3,4,5)now
print "@array\n";

@array[0..3]=(11,22,33,44);     #@array=(11,22,33,44,5)now
print "@array\n";

@array[1,2,3]=@array[3,2,4];    #@array=(11,44,33,5,5)now
print "@array\n";

@array[0..2]=@array[3,4];       #@array=(5,5,"",5,5)now


#################################
#可以用子数组形式来交换元素：
#################################
warn "------------------8";
@array[1,2]=@array[2,1];
print "@array\n";


######################################
#有关Perl数组的库函数
######################################

warn "------------------8";
#sort--按字符顺序排序

@array=("this","is","a","test");
print "now the \@array is @array\n";

@array=sort(@array);	        #@array=("a","is","test","this")
print "now after sort the \@array is @array\n";

@array=(70,100,8);
print "now the \@array is @array\n";

@array=sort(@array); #@array=(100,70,8)now
print "now after sort the \@array is @array\n";


#################################
#reverse--反转Perl数组
#################################
warn "------------------9";

my @array2=reverse(@array);     #now @array2=(8,70,100),@array=(100,70,8)
print "now the \@array is @array\n";
print "now after reverse the \@array2 is @array2\n";

@array2=reverse(sort(@array));
print "now after sort and  reverse the \@array2 is @array2\n";

#chop--Perl数组去尾 ( 注意其与 chomp 差别 )
#chop的意义是去掉STDIN（键盘）输入字符串时最后一个字符--换行符。
#而如果它作用到Perl数组上，则将Perl数组中每一个元素都做如此处理。
warn "------------------10";
my @list=("rabbit ","12345 ","quartz ");
print "now the array \@list is @list\n";

chop(@list);	                #@list=("rabbi","1234","quart")now
print "now after chop the array \@list is @list\n";

#join/split--连接/拆分
#join的第一个参数是连接所用的中间字符，其余则为待连接的字符Perl数组。
warn "------------------11";

my $string=join("","this","is","a","string");   #结果为"thisisastring"
print "now after the join the \$string is $string\n";

@list=("words","and");
print "now the array \@list is @list\n";

$string=join("::",@list,"colons");              #结果为"words::and::colons"
print "now after the join the \$string is $string\n";

@array=split(/::/,$string);#@array=("words","and","colons")now
print "now after split the $string \@array is @array\n";

#####################对数组的操作############################
# push：从数组的末尾加入元素 数组右边
# pop ：从数组的末尾取出元素 数组右边
# shift：从数组的开头取出元素 数组左边
# unshift：从数组的开头加入元素 数组左边
#############################################################

warn "------------------12";
#####push demo#######
@array=();	#数组初始化为空列表
for (my $i = 1; $i <=5; ++$i){
	push @array,$i;
	print "@array\n";
}

#####pop demo#######
@array=(1,2,3,4,5,6);
while (@array){
	my $first=pop(@array);
	print "$first\t@array\n";
}
#####unshift demo#######
@array=();	#数组初始化为空列表
for (my $i = 1; $i <=5; ++$i){
	unshift @array,$i;
	print "@array\n";
}
#####shift demo#######
@array=(1,2,3,4,5,6);
while (@array){
	my $first=shift(@array);
	print "$first\t@array\n";
}


######splice demo##########
# 操作数组中间部分的函数，该函数主要有2个作用：
# 第1个作用，向数组中间插入内容
##########################
my @tmparray=(0 .. 6);
my @tmparray2=('a' .. 'd');
print @tmparray,@tmparray2,"\n";
my @replaced = splice(@tmparray,3,2,@tmparray2); #用@tmparray2将@tmparray中的
#第3个元素开始的2个元素长的数组内容替换掉,此时splice返回的是替换的列表
print "replaced:@replaced\n","with:@tmparray2\n","resulting in:@tmparray\n\n";

#第2个作用，删除数组元素
my @tarray = (0 .. 6);
my @tarray1 = ('a' .. '6');
#my @treplaced = splice(@tarray,3,2); #从第3个元素开始删除2个元素
my @treplaced = splice(@tarray,3); #从第3个元素开始删除到最后所有的元素
print "replaced:@treplaced\n",
	"resulting in:@tarray\n";

=cut

=rocks 控制变量
控制变量不是这些列表元素中的一个拷贝而是这些元素本身。
也就是说,如果在循环中修改这个变量,那原始列表中的元
素也会被修改,如下面代码段所显示。这条性质是有用的,但
是,如果不清楚,可能对其结果感到吃惊
=cut

=ppppppppppp

my @rocks = qw/bedrock slate lava /;
foreach my $rock (@rocks){
$rock = "\t$rock"; 	                #@rocks 的每一个元素前加入一个 tab 
$rock .= "\n"; 		                #每一个元素后加一个换行符
}
print "The rocks are:\n",@rocks; #每一个元素都被缩进了,并且一个元素占一行


=default param $_
使用默认的变量$_
foreach(1..10){
    print "I can count to $_!\n";   #使用默认的变量$_
}
=cut
