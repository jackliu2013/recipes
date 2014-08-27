#!/usr/bin/env perl

use strict;
use warnings;

use Zeta::Run;
use ZAPP::DT;
use ZAPP::YSPZ::Load;
use ZAPP::CALC::Calc;
use Zark;
use File::Path qw/mkpath/;
use File::Copy qw/cp/;
use Getopt::Long;
use IO::File;
use Data::Dump;

my $YS_TYPE = '0081';

my %args;
$args{type}     = $YS_TYPE;
$args{conf}     = "$ENV{ZIXAPP_HOME}/conf/load/$args{type}.load";
$args{datafile} = "$ENV{ZIXAPP_HOME}/tdata/load/$args{type}.src";

&check(\%args);
my $load   = &prep(\%args);
my $loader = &setup($load);

#
# 1. 合并汇总， 把所有的失败文件合并一个总的文件
# 2. 同一matcher构成项的数据只要第一条
# 3. 调用tload,
# 4. 根据tload的返回的结果进行分析

# 把所有的fail文件合并成一个fail文件
my $fname = 'fail.total';
my $i     = 0;
for ( $i = 0 ; $i < 10 ; $i++ ) {
    if ( -f "x$i.fail" ) {
        my $total = `wc -l x$i.fail | awk '{ print \$1}'`;
        if ( $total > 0 ) {
            if ( $i > 0 ) {
                `cat x$i.fail >>$fname`;
            }
            else {
                `cat x$i.fail >$fname`;
            }
        }
    }
}

my %hash;
my $key;
my $row;
my $rfh = IO::File->new( $fname, "r" );

# 最后输出的文件
# 文件最后输出位置 dev环境及UAT环境输出的位置为
# my $wfh = IO::File->new("~/zixapp/tdata/load/0081.src" , "w");
my $wfh = IO::File->new( "$ENV{HOME}/workspace/zixapp/tdata/load/0081.src", "w" );

while (<$rfh>) {
    $row = [ split '\|' ];

    # matcher 构成项 + BI
    # $row->[3] 卡类 $row->[4] 业务类型
    $key = $row->[3] . $row->[4] . $row->[9];

    # 同一matcher构成项+BI的只读取一条数据
    if ( exists $hash{$key} ) {
        next;
    }
    else {
        $hash{$key} = $row;
    }

    # 输出数据
    # $wfh->print($_);
    my $yspz = $load->{$args{type}}->($loader, $_);
    #$wfh->print($yspz);
    $wfh->print("$_ , matcher=[$yspz->{matcher}],bi=[$yspz->{bi}],bfj_acct_bj=[$yspz->{bfj_acct_bj}]\n");

}

$rfh->close();
$wfh->close();

######################################################
#
# desc   : 检查输输入的命令行参数
#
sub check {
    my $args = shift;
    unless ( $args->{type} ) {
        warn "无效类型";
        &usage;
    }
    unless ( $args->{datafile} ) {
        warn "未提供数据文件";
        &usage;
    }
    unless ( -f $args->{datafile} ) {
        warn "数据文件[$args->{datafile}]不存在";
        &usage;
    }
    unless ( $args->{conf} ) {
        $args->{conf} = "$ENV{ZIXAPP_HOME}/conf/load/$args->{type}.load";
    }
    unless ( -f $args->{conf} ) {
        die "$args->{conf} does not exists";
    }
}

#
# desc   : 准备
# input  : $args  -  输入参数
# output :
#     load配置hash
#
sub prep {
    my $args = shift;
    my $load = do $args->{conf};
    unless ($load) {
        die "can not load $args->{conf}";
    }
    return { $args->{type} => $load };
}

#
# desc   : 产生loader对象
# input  :
# output :
#
sub setup {
    my $load = shift;
    my $cfg  = do "$ENV{ZIXAPP_HOME}/conf/zixapp.conf";
    my $proc = do "$ENV{ZIXAPP_HOME}/conf/proc.conf";
    $cfg->{dbh}  = zkernel->zdbh();
    $cfg->{zark} = Zark->new( dbh => $cfg->{dbh}, proc => $proc, setup => 1 );
    $cfg->{dt}   = ZAPP::DT->new($cfg);
    $cfg->{calc} = ZAPP::CALC::Calc->new($cfg);
    my $loader = ZAPP::YSPZ::Load->new( $cfg, $load, 1 );
    return $loader;
}
