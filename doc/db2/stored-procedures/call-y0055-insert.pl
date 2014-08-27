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

my $wfh = IO::File->new(">ins-y0055.sql");

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

my $i = 1;
my $max = 500;
my $sth;
my $ins_sql = " insert into y0055(serialno, txdate, c, cardtype, p, txamt, cfee, cwwscfee, bfjacctbj, bi, bserialno, btxdate, cleardate, bfee, dealdate ) values ";
my $val_sql;

my $serialno    = "CBHBNEB2CBHPX10101211458442";
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

    if ( $i % 500 ) {
        $val_sql .= "('$serialno', '$txdate', '$c', $cardtype, $p, '$txamt', '$cfee', '$cwwscfee', $bfjacctbj, '$bi', '$bserialno', '$btxdate', '$cleardate', '$bfee', '$dealdate'), ";
    }
    else {
        $val_sql .= "('$serialno', '$txdate', '$c', $cardtype, $p, '$txamt', '$cfee', '$cwwscfee', $bfjacctbj, '$bi', '$bserialno', '$btxdate', '$cleardate', '$bfee', '$dealdate'); ";
    }

    unless ( $i % 500 ) {
     $wfh->print($ins_sql . $val_sql . "\n");
     # $sth = $dbh->prepare($ins_sql . $val_sql);
     # $sth->execute();
     # $sth->finish();
     # $dbh->commit(); 
    }
    $i++;
    
}

$dbh->commit();
print "Time wasted: $now\n";
$dbh->disconnect();
