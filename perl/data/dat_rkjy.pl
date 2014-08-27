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
  qw/C_MERCHANT_NO	C_PAY_SERIALNO	D_PAY_DATE	F_PAY_BALANCE	F_INCOME_BALANCE	C_CHANNEL_NO	C_BANK_SERIALNO	D_BANK_CONFIRM_DATE	D_BANK_CLEAR_DATE	F_INNER_BANK_BALANCE	F_OUTER_BANK_BALANCE	C_RECONCILE_TYPE	D_CREATE_DATE/;

while (<>) {
    s/^\s+|\s+$//g;
    next unless /^\w+/;

    my @val = split ',';

    #Data::Dump->dump(@val);
	#F_PAY_BALANCE F_INCOME_BALANCE F_INNER_BANK_BALANCE F_OUTER_BANK_BALANCE 为空时赋值0
    $val[3] = 0 if ( $val[3] eq '' );
    $val[4] = 0 if ( $val[4] eq '' );
    $val[9] = 0 if ( $val[9] eq '' );
    $val[10] = 0 if ( $val[10] eq '' );

    my $sql = sprintf(
        "insert into source_skjy_gd (%s) values (%s)",
        join( ', ', @fld ),
        join( ', ', ('?') x @fld )
    );

    my $sth = $dbh->prepare($sql);
    #Data::Dump->dump($sql);

    $sth->execute(@val);
}

$dbh->disconnect();
