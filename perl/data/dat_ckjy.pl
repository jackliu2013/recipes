#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use Data::Dump;

##	创建db handler 连接数据库
my $dbh = DBI->connect( 'dbi:DB2:zdb_dev', 'ypinst', 'ypinst', );

unless ($dbh) {
    exit 0;
}

my @fld =
  qw/C_MERCHANT_NO C_OUT_SERIALNO C_OUT_TYPE F_OUT_BALANCE F_INCOME_BALANCE	C_BANK_NO D_BANK_CONFIRM_DATE
  F_INNER_BANK_BALANCE F_OUTER_BANK_BALANCE D_CREATE_DATE/;

while (<>) {
    s/^\s+|\s+$//g;
    next unless /^\w+/;
    my @val = split ',';

#F_OUT_BALANCE F_INCOME_BALANCE F_INNER_BANK_BALANCE F_OUTER_BANK_BALANCE 为空时，赋值0
    $val[3] = 0 if ( $val[3] eq '' );
    $val[4] = 0 if ( $val[4] eq '' );
    $val[7] = 0 if ( $val[7] eq '' );
    $val[8] = 0 if ( $val[8] eq '' );

    #  Data::Dump->dump(@val);
    my $sql = sprintf(
        "insert into source_jsck (%s) values (%s)",
        join( ', ', @fld ),
        join( ', ', ('?') x @fld )
    );

    my $sth = $dbh->prepare($sql);
    Data::Dump->dump($sql);

    $sth->execute(@val);
}

$dbh->disconnect();

