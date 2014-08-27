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


my $i = 4;
my $dt1;
my $dt2;
my $sth;

while ( $i < 20 ) {
    $dt1      = DateTime->now( time_zone => 'local' );
    Data::Dump->dump( $dt1->hour . ":" . $dt1->minute . ":" . $dt1->second );

    $sth = $dbh->prepare("call SYSPROC.XDB_DECOMP_XML_FROM_QUERY(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    my $schema = 'db2inst';
    my $xsd = 'cust2xsd';
    my $sql = 'select cid, info from customer';
    # $sth = $dbh->prepare("call SYSPROC.XDB_DECOMP_XML_FROM_QUERY('db2inst', 'cust2xsd', 'select info from customer',  0, 25, 1, NULL, NULL, '1', ?, ?, ?)");
    $sth->execute($schema, $xsd, $sql, '0', '25', '1', undef, undef, '1', undef, undef, undef );
    $sth->finish();
    $dbh->commit();
    $dt2 = DateTime->now( time_zone => 'local' );

    Data::Dump->dump( $dt2->hour . ":" . $dt2->minute . ":" . $dt2->second );
    $i++;
}
$dbh->disconnect();
