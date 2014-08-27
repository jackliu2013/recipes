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

my $serialno    = 'CBHB_NET_B2C_BHPX1010#1211458442';
my $txdate      = '2013-12-30';
my $c           = '10011427722';
my $cardtype    = '1';
my $p           = '15';
my $txamt       = '80.00';
my $cfee        = '0.00';
my $cwwscfee    = '0.00';
my $bfjacctbj   = '1';
my $bi          = 'CBHB_NET_B2C_BHPX1010';
my $bserialno   = '2322713472';
my $btxdate     = '2013-12-30';
my $cleardate   = '2013-12-30';
my $bfee        = '1.00';
my $dealdate    = '2013-12-31';


Time::Elapse->lapse(my $now);
while ( $i <= $max ) {
    $sth = $dbh->prepare("insert into y0055(serialno, txdate, c, cardtype, p, txamt, cfee, cwwscfee, 
                        bfjacctbj, bi, bserialno, btxdate, cleardate, bfee, dealdate) 
                        values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $sth->execute($serialno, $txdate, $c, $cardtype, $p, $txamt, $cfee, $cwwscfee, $bfjacctbj, $bi, 
                  $bserialno, $btxdate, $cleardate, $bfee, $dealdate);
    $sth->finish();
    $i++;
    $j++;
    $dbh->commit() if ($j == 500);
}
$dbh->commit();
print "Time wasted: $now\n";
$dbh->disconnect();
