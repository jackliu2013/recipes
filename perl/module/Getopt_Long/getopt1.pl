#!/usr/bin/perl -w
use strict;

use Data::Dump;
use Getopt::Long;

#########################################
# declare default values for variables
#########################################

#
# 三个变量没有默认值
#
my $data;
my $length ;
my $verbose ;

#
# =后面说明该选项需要值
# =i    需要的是整数值
# =f    需要的是浮点数
# =s    需要的是字符串
# =+    可增加的选项(可出现多次)
# 当= 被: 代替的时候，说明该命令选项是可选的，如果该命令选项没有合适的值
# 字符串会被当作空串''，数字会被当作0 来处理
#
my $result  = GetOptions(
    "length=i" => \$length,    # numeric
    "file=s"   => \$data,      # string
    "verbose+" => \$verbose    # flag
);

&usage unless ( $length && $data );

if ( $verbose eq '' ) {
    print "\$verbose is '' \n";
}

#Data::Dump->dump($result);
if ($result) {
#################################################################
    # test perl getopt1.pl --length 10 --data dat --verbose 2
    # test perl getopt1.pl -length 10 -data dat -verbose 2
#################################################################
    print <<EOF;
length:		$length
file:		$data
verbose:	$verbose
EOF
}

sub usage {
    print <<EOF;
usage : getop1.pl -length num -file filename [-verbose]
EOF
    exit 1;
}
