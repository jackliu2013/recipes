#!/usr/bin/evn perl

use DBI;
use Data::Dump;
use DateTime;

use strict;
use warnings;

my $cfg = {
    dsn    => "dbi:DB2:zdb_dev",
    user   => "db2inst",
    pass   => "db2inst",
    schema => "db2inst",
};

# Data::Dump->dump($cfg);

# 建立数据库连接
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

unless ($dbh) {
    die "cannot connect to db";
}

my $sth = $dbh->prepare("select count(*) from y0055");
$sth->execute();
my ($count) = $sth->fetchrow_array;
print "count is $count" . "\n";

$sth->finish();
$dbh->commit();
$dbh->disconnect();
