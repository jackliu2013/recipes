#!/usr/bin/env perl

use strict;
use warnings;

# 学习Net::FTP
use Net::FTP;
use Data::Dump;

# ftp 主机IP 用户名 密码
my $ftp_host = "127.0.0.1";
my $ftp_user = "epos";
my $ftp_pwd  = "epos";

# 新建一个Net::FTP 对象
my $ftp = Net::FTP->new( $ftp_host, Debug => 0 )
  or die "Cannot connect to $ftp_host : $@";

# 登录FTP服务器
$ftp->login( $ftp_user , $ftp_pwd )
  or die "Cannot login ", $ftp->message;

# 改变目录
$ftp->cwd("/20130819")
  or die "Cannot change working directory ", $ftp->message;

# 下载数据
#$ftp->get("epos-0090-20130819.dat")
#  or die "get failed ", $ftp->message;

# 上传数据
$ftp->put( "aa" )
  or die "put failed ", $ftp->message;

# 退出FTP
$ftp->quit;
