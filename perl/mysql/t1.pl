#!/usr/bin/perl -w

use strict;
use DBI;

my $dsn      = "DBI:mysql:database=mldn;host=localhost";
my $user     = 'jackliu';
my $password = '123456';
my ( $dbh, $sth, @ary );
$dbh = DBI->connect( $dsn, $user, $password );    #连接数据库
$sth = $dbh->prepare("select * from user");     #准备
$sth->execute();                                  #执行

while ( @ary = $sth->fetchrow_array() ) {
    print join( "\t", @ary ), "\n";
}                                                 #打印抽取结果
$sth->finish;                                     #结束句柄
$dbh->disconnect;                                 #断开
