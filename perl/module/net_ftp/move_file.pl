#!/usr/bin/perl
use strict;
use warnings;
use Net::FTP;
use IO::File;
use DateTime;
use File::Path qw/mkpath/;
use IO::Dir;
use Getopt::Long;
use Zeta::Log;

# 上传文件的FTP服务器
my $ftp_up_host = 'canna';
my $ftp_up_usr  = 'kjdj';
my $ftp_up_pwd  = 'kjdj';

# 下载FTP文件的服务器
my $ftp_dw_host = 'tulip';
my $ftp_dw_usr  = 'kjdj';
my $ftp_dw_pwd  = 'kjdj';

#
# 1. 把生产服务器的流水文件下载到本地一个目录，
# 2. 生成每个流水文件对应的ok文件,
# 3. 把本地目录的流水文件及ok文件上传到UAT环境
#

#
# ./move_file.pl -f[0048|all] -t pos -d 20131019
# -f 0048 : 传递0048的流水文件及ok文件
# -f all  : 传递某个行业线下所有的流水文件

# 读待处理文件命名日期
my $date;
my $file;
my $type;
my $rtn = GetOptions(
    "file|f=s" => \$file,
    "date|d=i" => \$date,
    "type|t=s" => \$type,
) or die "can not GetOptions";

unless ( $file && ( $file =~ /^\d{4}$/ || $file =~ /^all$/ ) ) {
    &usage;
}
unless ( $date && $date =~ /^\d{8}$/ ) {
    &usage;
}
unless ($type) {
    &usage;
}

# 引入打印日志模块
my $log = Zeta::Log->new(
    logurl   => 'stderr',
    loglevel => 'DEBUG',
);

# 本地文件路径
my $local_up_path = "/home/jackliu/kjdj/data/$type/collate/$date";
mkpath($local_up_path);
chdir $local_up_path or die "Cannot change local dir";

# 下载文件路径
my $ftp_down_path = "./data/$type/collate/$date";
my $dw_file ;
my $ok_file ;

# 开始下载文件
my $ftp = Net::FTP->new( "$ftp_dw_host", Debug => 0 ) or die "Cannot connect to tulip : $@";
# login ftp server
$ftp->login( "$ftp_dw_usr", "$ftp_dw_pwd" ) or die "Cannot login";
$log->debug("login succeed");

# change dir 
$ftp->cwd("$ftp_down_path") or die "Cannot change work dir", $ftp->message;
$log->debug("chdir succeed");

# get 流水文件
# if $file =~ /^all$/ 下载所有的流水文件 
# else 下载指定的流水文件
if ( $file =~ /^all$/ ) {
    my $f_name;
    if ( $type eq 'pos' ) {
        $f_name = &get_pos();
    }

    foreach (@$f_name) {
       $dw_file = "$type-$_-$date.dat"; 
       $ftp->get("$dw_file") or die "get failed ", $ftp->message;
       $log->info("get:$dw_file succeed");

       $ok_file = "ok.$type-$_-$date";
       system("touch $ok_file");
       $log->info("$ok_file touch succeed");
    }
   
}
elsif ( $file =~ /^\d{4}$/ ) {
    $dw_file     = "$type-$file-$date.dat";
    $ftp->get("$dw_file") or die "get failed ", $ftp->message;
    $log->info("get:$dw_file succeed");

    $ok_file = "ok.$type-$file-$date";
    system("touch $ok_file");
    $log->info("$ok_file touch succeed");
}

# 中断FTP连接
$ftp->quit;



# 上传文件路径
my $ftp_up_path = "data/$type/collate/$date";
my $up_file;
chdir $local_up_path or die "Cannot change local dir";
$log->debug("本地路径切换:$local_up_path succeed");

# 开始上传文件
$ftp = Net::FTP->new( "$ftp_up_host", Debug => 0 ) or die "Cannot connect to canna: $@";

# login ftp server
$ftp->login( "$ftp_up_usr", "$ftp_up_pwd" ) or die "Cannot login";
$log->debug("login succeed");

# mkpath and chdir
# 递归创建目录
$ftp->mkdir($ftp_up_path,1) or die "Cannot mkdir\n" , $ftp->message;
$ftp->cwd($ftp_up_path) or die "Cannot change work dir\n", $ftp->message;
$log->debug("chdir succeed");

# up files
if ( $file =~ /^all$/ ) {
    my $uf_name;
    if ( $type eq 'pos' ) {
        $uf_name = &get_pos();
    }

    foreach (@$uf_name) {
       $up_file = "$type-$_-$date.dat"; 
       $ftp->put("$up_file") or die "put $up_file failed ", $ftp->message;
       $log->info("put:$up_file succeed");

       $ok_file = "ok.$type-$_-$date";
       $ftp->put("$ok_file") or die "put $ok_file failed ", $ftp->message;
       $log->info("$ok_file put succeed");
    }
   
}
elsif ( $file =~ /^\d{4}$/ ) {
    $up_file     = "$type-$file-$date.dat";
    $ftp->put("$up_file") or die "put $up_file failed ", $ftp->message;
    $log->info("put:$up_file succeed");

    $ok_file = "ok.$type-$file-$date";
    $ftp->put("$ok_file") or die "put $ok_file failed ", $ftp->message;
    $log->info("$ok_file put succeed");
}

# ftp disconnect
$ftp->quit;

sub usage {
    die
"请按要求格式输入： 如： ./move_file -f [0068|all] -t pos -d 20131019\n";
}

sub get_pos {
   my @arr = qw/0032 0033 0034 0035 0036 
                0037 0038 0039 0040 0045 
                0046 0047 0048 0049 0050 
                0051 0102/;
   return \@arr;
}
