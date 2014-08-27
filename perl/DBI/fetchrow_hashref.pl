#!/usr/bin/perl

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

my %dim;
my $sth = $dbh->prepare(qq/select * from dict_dim where dim='acct'/) or return;
$sth->execute();
while ( my $row = $sth->fetchrow_hashref() ) {
    Data::Dump->dump($row);
    $dim{ delete $row->{dim} } = $row;
    # Data::Dump->dump($row);
}

warn "----------------------------------------";
Data::Dump->dump(%dim);
$sth->finish();

$dbh->commit();
$dbh->disconnect();
