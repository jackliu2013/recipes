#!/usr/bin/evn perl

use DBI;
use Data::Dump;
use DateTime;
use Time::Elapse;

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


my $i = 1;
my $j = 1;
my $max = 30000;
my $dt1;
my $dt2;
my $sth;

Time::Elapse->lapse(my $now);
while ( $i <= $max ) {
    $sth = $dbh->prepare("call SYSPROC.XDB_DECOMP_XML_FROM_QUERY(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    my $schema = 'db2inst';
    my $xsd = 'y0055xsd';
    my $sql = 'select id, info from test0055';
    $sth->execute($schema, $xsd, $sql, '0', '25', '1', undef, undef, '1', undef, undef, undef );
    $sth->finish();
    $i++;
    $j++;
    $dbh->commit() if ($j == 500);
}
$dbh->commit();
print "Time wasted: $now\n";
$dbh->disconnect();
