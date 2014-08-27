#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use IO::File;
use IO::Dir;

## 创建file handle
my $fh;
##	创建db handler 连接数据库
my $dbh = DBI->connect( 'dbi:DB2:zdb_dev', 'ypinst', 'ypinst', );

unless ($dbh) {
    exit 0;
}
=pod
my $sth = $dbh->prepare(
    "select C_MERCHANT_NO,        C_PAY_SERIALNO,
        D_PAY_DATE,           F_PAY_BALANCE,
        F_INCOME_BALANCE,     C_CHANNEL_NO,
        C_BANK_SERIALNO,      D_BANK_CONFIRM_DATE,
        D_BANK_CLEAR_DATE,    F_INNER_BANK_BALANCE,
        F_OUTER_BANK_BALANCE, C_RECONCILE_TYPE,
        D_CREATE_DATE from  sktx_gdh_data

"
);
unless ($sth) {
    warn "can not prepare sktx_gdh_data";
    exit 0;
}
=cut

###########0002.src############
#my $narray = $sth->{NAME};
#my @dim = join "|", map { lc } @$narray;

##取出创建目录的时间
my $sth = $dbh->prepare(
    " select C_MERCHANT_NO,        C_PAY_SERIALNO,
        D_PAY_DATE,           F_PAY_BALANCE,
        F_INCOME_BALANCE,     C_CHANNEL_NO,
        C_BANK_SERIALNO,      D_BANK_CONFIRM_DATE,
        D_BANK_CLEAR_DATE,    F_INNER_BANK_BALANCE,
        F_OUTER_BANK_BALANCE, C_RECONCILE_TYPE,
        D_CREATE_DATE from  sktx_gdh_data  where C_RECONCILE_TYPE='1' "
);
$sth->execute();
my $row;
########mkdir begin#########
while ( $row = $sth->fetchrow_arrayref ) {
    my $filepath = join( "", split( "-", ( substr $row->[12], 0, 10 ) ) );
    my $filename = "0002.src";

    #    Data::Dump->dump($filename);

    if ( -d $filepath ) {
        chdir($filepath);
        if ( -e $filename ) {
            $fh = IO::File->new(">>$filename");
            $fh->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh = IO::File->new(">$filename");

            #打印字段的表头
 #           $fh->print(<<EOF);
#@dim
#EOF
            $fh->print( join '|', @{$row}, "\n" );
        }
        chdir("..");
    }
    else {
        mkdir "$filepath";
        chdir($filepath);

        if ( -e $filename ) {
            $fh = IO::File->new(">>$filename");
            $fh->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh = IO::File->new(">$filename");

            #打印字段的表头
            #$fh->print(<<EOF);
#@dim
#EOF
            $fh->print( join '|', @{$row}, "\n" );
        }
        chdir("..");
    }
}

##释放$sth占用的资源
$sth->finish();
##0003.src
my $fh1;
$sth = $dbh->prepare(
"select C_MERCHANT_NO, C_PAY_SERIALNO ,D_PAY_DATE ,F_PAY_BALANCE, F_INCOME_BALANCE, C_CHANNEL_NO, C_RECONCILE_TYPE, D_CREATE_DATE  from   sktx_gdh_data  where C_RECONCILE_TYPE='2' "
);

#$nhash = $sth->{NAME_hash};
$sth->execute();
######################mkdir###############################
while ( $row = $sth->fetchrow_arrayref ) {
    my $filepath = join( "", split( "-", ( substr $row->[7], 0, 10 ) ) );
    my $filename = "0003.src";

    if ( -d $filepath ) {
        chdir($filepath);

        if ( -e $filename ) {
            $fh1 = IO::File->new(">>$filename");
            $fh1->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh1 = IO::File->new(">$filename");
  #          $fh1->print(<<EOF);
#@dim
#EOF
            $fh1->print( join '|', @{$row}, "\n" );

        }
        chdir("..");
    }
    else {
        mkdir "$filepath";
        chdir($filepath);

        if ( -e $filename ) {
            $fh1 = IO::File->new(">>$filename");
            $fh1->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh1 = IO::File->new(">$filename");
           # $fh1->print(<<EOF);
#@dim
#EOF
            $fh1->print( join '|', @{$row}, "\n" );
        }
        chdir("..");
    }
}
##释放$sth占用的资源
$sth->finish();
my $fh2;
$sth = $dbh->prepare(
"select F_PAY_BALANCE, F_INCOME_BALANCE ,C_CHANNEL_NO ,C_BANK_SERIALNO, D_BANK_CONFIRM_DATE ,D_BANK_CLEAR_DATE, F_INNER_BANK_BALANCE, F_OUTER_BANK_BALANCE, C_RECONCILE_TYPE, D_CREATE_DATE from sktx_gdh_data  where C_RECONCILE_TYPE='3' "

);

#$nhash = $sth->{NAME_hash};
$sth->execute();
######################mkdir###############################
while ( $row = $sth->fetchrow_arrayref ) {
    my $filepath = join( "", split( "-", ( substr $row->[9], 0, 10 ) ) );
    my $filename = "0004.src";

    #print "$filepath\n";
    if ( -d $filepath ) {
        chdir($filepath);

        if ( -e $filename ) {
            $fh2 = IO::File->new(">>$filename");
            $fh2->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh2 = IO::File->new(">$filename");
  #          $fh2->print(<<EOF);
#@dim
#EOF
            $fh2->print( join '|', @{$row}, "\n" );

        }
        chdir("..");
    }
    else {
        mkdir "$filepath";
        chdir($filepath);

        if ( -e $filename ) {
            $fh2 = IO::File->new(">>$filename");
            $fh2->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh2 = IO::File->new(">$filename");
 #           $fh2->print(<<EOF);
#@dim
#EOF
            $fh2->print( join '|', @{$row}, "\n" );
        }
        chdir("..");
    }
}

##释放$sth占用的资源
$sth->finish();
##断开与数据库的连接
$dbh->disconnect();
##关闭文件IO
$fh->close();
#$fh1->close();
$fh2->close();
