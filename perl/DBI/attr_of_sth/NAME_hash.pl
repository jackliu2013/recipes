#!/usr/bin/perl

#
# fetchall_arrayref fetch所有的数据，返回一个数组的引用，并且
# 该引用指向的数组的每个元素又是一个数组的引用
#
use strict;
use warnings;
use DBI;
use Data::Dump;

my $cfg = {
    dsn    => "dbi:DB2:$ENV{DB_NAME}",
    user   => "$ENV{DB_USER}",
    pass   => "$ENV{DB_PASS}",
    schema => "$ENV{DB_SCHEMA}",
};

# Data::Dump->dump($cfg);

# 建立数据库连接
# 创建database handle object dbh
my $dbh = DBI->connect(
    $cfg->{dsn},
    $cfg->{user},
    $cfg->{pass},
    {
        RaiseError       => 1,
        PrintError       => 0,
        AutoCommit       => 0,
        FetchHashKeyName => 'NAME_lc',

    }
);


my %attr;

# SQL
my $sql = "select id,value from dict_book";

# 创建statement handle object (sth)
my $sth_sel = $dbh->prepare( $sql, \%attr ) or die $dbh->errstr ;  

# SQL 语句结束
$sth_sel->finish();

# 执行SQL
my $name_hash = $sth_sel->{NAME_hash};

Data::Dump->dump( $name_hash ) ;

$dbh->commit;
$dbh->disconnect;
