#!/usr/bin/perl

=comment

# fetch 所有的数据，返回一个数组的引用，每行数据也是一个数组引用
$tbl_ary_ref = $sth->fetchall_arrayref;                         

# fetch 所有的数据，返回一个数组的引用，每行数据也是一个数组引用($slice是数组引用时，$slice可指定每行返回的列数)
$tbl_ary_ref = $sth->fetchall_arrayref( $slice ); 

# fetch 所有的数据，返回一个数组的引用，每行数据是一个哈希引用($slice是哈希引用时，$slice可指定每行返回的列数)
$tbl_ary_ref = $sth->fetchall_arrayref( $slice, $max_rows  );


The fetchall_arrayref method can be used to fetch all the data to be returned from a prepared and executed statement handle. It returns a reference to an array that contains one reference per row.

If called on an inactive statement handle, fetchall_arrayref returns undef.

If there are no rows left to return from an active statement handle, fetchall_arrayref returns a reference to an empty array. If an error occurs, fetchall_arrayref returns the data fetched thus far, which may be none. You should check $sth->err afterwards (or use the RaiseError attribute) to discover if the data is complete or was truncated due to an error.

If $slice is an array reference, fetchall_arrayref uses "fetchrow_arrayref" to fetch each row as an array ref. If the $slice array is not empty then it is used as a slice to select individual columns by perl array index number (starting at 0, unlike column and parameter numbers which start at 1).

With no parameters, or if $slice is undefined, fetchall_arrayref acts as if passed an empty array ref.

If $slice is a hash reference, fetchall_arrayref fetches each row as a hash reference. If the $slice hash is empty then the keys in the hashes have whatever name lettercase is returned by default. (See "FetchHashKeyName" attribute.) If the $slice hash is not empty, then it is used as a slice to select individual columns by name. The values of the hash should be set to 1. The key names of the returned hashes match the letter case of the names in the parameter hash, regardless of the "FetchHashKeyName" attribute.

=cut

#
# fetchall_arrayref fetch所有的数据，返回一个数组的引用，并且
# 该引用指向的数组的每个元素又是一个数组的引用
#
use strict;
use warnings;
use DBI;
use Data::Dump;

my $cfg = {
    dsn    => "dbi:DB2:$ENV{DB_NAME}",
    user   => "$ENV{DB_USER}",
    pass   => "$ENV{DB_PASS}",
    schema => "$ENV{DB_SCHEMA}",
};

# Data::Dump->dump($cfg);

# 建立数据库连接
# 创建database handle object dbh
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

# Data::Dump->dump( $dbh ) ;
my %attr;

# SQL
my $sql = "select * from study.student";

# 创建statement handle object (sth)
my $sth_sel = $dbh->prepare( $sql, \%attr ) or die $dbh->errstr ;  

# SQL 语句结束
$sth_sel->finish();

# 执行SQL
$sth_sel->execute();

# fetch 数据 1
my $aref = $sth_sel->fetchall_arrayref();
Data::Dump->dump( $aref ) ;

$sql = "select * from study.student";
$sth_sel = $dbh->prepare( $sql, \%attr ) or die $dbh->errstr ;  
# 执行SQL
$sth_sel->execute();
# fetch 数据 2  每行数据只fetch 2 列
$aref = $sth_sel->fetchall_arrayref( [0 .. 1] );
Data::Dump->dump( $aref ) ;

$sql = "select * from study.student";
$sth_sel = $dbh->prepare( $sql, \%attr ) or die $dbh->errstr ;  
# 执行SQL
$sth_sel->execute();
# fetch 数据 3 
# $aref = $sth_sel->fetchall_arrayref( { id => 0, name => 1 });
$aref = $sth_sel->fetchall_arrayref( { id => 1, name => 1 });
Data::Dump->dump( $aref ) ;


$dbh->commit();
$dbh->disconnect;
