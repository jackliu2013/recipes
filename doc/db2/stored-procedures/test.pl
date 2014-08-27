#!/usr/bin/evn perl

use strict;
use warnings;

use DBI;
use Data::Dump;
use DateTime;
use Time::Elapse;
use IO::File;


my $cfg = {
    dsn    => "dbi:DB2:zdb_dev",
    user   => "db2inst",
    pass   => "db2inst",
    schema => "db2inst",
};

my $rfh = IO::File->new("<ins-y0055.sql");

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

$dbh->do("set current schema db2inst");

my $sth;

Time::Elapse->lapse(my $now);
while ( <$rfh> ) {
   my $sql = $_;
   for ( my $i = 0; $i<= 60 ; $i++ ) {
     $sth = $dbh->prepare($sql);
     $sth->execute();
     $sth->finish();
    }
}

$dbh->commit();
print "Time wasted: $now\n";
$dbh->disconnect();
