#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use IO::File;
use IO::Dir;
#use Data::Dump;

## 创建file handler
my $fh;
##	创建db handler 连接数据库
my $dbh = DBI->connect( 'dbi:DB2:zdb_dev', 'ypinst', 'ypinst', );

unless ($dbh) {
    exit 0;
}

=pppppp 暂时屏蔽表头
#my $sth = $dbh->prepare(
#"select C_MERCHANT_NO, C_OUT_SERIALNO, C_OUT_TYPE, F_OUT_BALANCE, F_INCOME_BALANCE, 
#	C_BANK_NO, D_BANK_CONFIRM_DATE, F_INNER_BANK_BALANCE, F_OUTER_BANK_BALANCE, D_CREATE_DATE from source_jsck"
#);
#unless ($sth) {
#    warn "can not prepare source_jsck";
#    exit 0;
#}
############生成结算出款数据############
#my $narray = $sth->{NAME};
#my @dim = join "|", map { lc } @$narray;
=cut

##取出创建目录的时间
my $sth = $dbh->prepare(
"select C_MERCHANT_NO, C_OUT_SERIALNO, C_OUT_TYPE, F_OUT_BALANCE, F_INCOME_BALANCE, 
	C_BANK_NO, D_BANK_CONFIRM_DATE, F_INNER_BANK_BALANCE, F_OUTER_BANK_BALANCE, D_CREATE_DATE 
	from source_jsck where C_OUT_TYPE = '1'"
);
$sth->execute();
my $row;
########mkdir begin#########
while ( $row = $sth->fetchrow_arrayref ) {
    my $filepath = join( "", split( "-", ( substr $row->[9], 0, 10 ) ) );
    my $filename = "0007.src";
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
        	$fh = IO::File->new(">>$filename" );
            $fh->print( join '|', @{$row}, "\n" );
        }
        else {
            $fh = IO::File->new(">$filename");
            #打印字段的表头
#            $fh->print(<<EOF);
#@dim
#EOF
            $fh->print( join '|', @{$row}, "\n" );
        }
        chdir("..");
    }
}

#释放$sth占用的资源
$sth->finish();

##	生成结算委托的数据
my $fh1;
$sth = $dbh->prepare(
"select C_MERCHANT_NO, C_OUT_SERIALNO, C_OUT_TYPE, F_OUT_BALANCE, F_INCOME_BALANCE, 
	C_BANK_NO, D_BANK_CONFIRM_DATE, F_INNER_BANK_BALANCE, F_OUTER_BANK_BALANCE, D_CREATE_DATE 
	from source_jsck where C_OUT_TYPE = '2' "
);

#$nhash = $sth->{NAME_hash};
$sth->execute();

######################mkdir###############################
while ( $row = $sth->fetchrow_arrayref ) {
    my $filepath = join( "", split( "-", ( substr $row->[9], 0, 10 ) ) );
    my $filename = "0009.src";

    #print "$filepath\n";
    if ( -d $filepath ) {
        chdir($filepath);
	
        if ( -e $filename ) {
        	$fh1 = IO::File->new( ">>$filename" );
            $fh1->print( join '|', @{$row}, "\n" );
        }
        else {
        	$fh1 = IO::File->new( ">$filename" );
#            $fh1->print(<<EOF);
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
        	$fh1 = IO::File->new( ">>$filename" );
            $fh1->print( join '|', @{$row}, "\n" );
        }
        else {
        	$fh1 = IO::File->new( ">$filename" );
#            $fh1->print(<<EOF);
#@dim
#EOF
            $fh1->print( join '|', @{$row}, "\n" );
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
$fh1->close();

