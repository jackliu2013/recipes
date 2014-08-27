#!/usr/bin/perl

=comment

$ary_ref = $dbh->selectcol_arrayref($statement);
$ary_ref = $dbh->selectcol_arrayref($statement, \%attr);
$ary_ref = $dbh->selectcol_arrayref($statement, \%attr, @bind_values);

This utility method combines "prepare", "execute", and fetching one column from all the rows, into a single call. 
It returns a reference to an array containing the values of the first column from each row.

The $statement parameter can be a previously prepared statement handle, in which case the prepare is skipped. 
This is recommended if the statement is going to be executed many times.

If any method except fetch fails, and "RaiseError" is not set, selectcol_arrayref will return undef. If fetch fails 
and "RaiseError" is not set, then it will return with whatever data it has fetched thus far. $DBI::err should be checked to catch that.

The selectcol_arrayref method defaults to pushing a single column value (the first) from each row into the result array. 
However, it can also push another column, or even multiple columns per row, into the result array. This behaviour can be 
specified via a 'Columns' attribute which must be a ref to an array containing the column number or numbers to use. For example:

# get array of id and name pairs:
my $ary_ref = $dbh->selectcol_arrayref("select id, name from table", { Columns=>[1,2] });
my %hash = @$ary_ref; # build hash from key-value pairs so $hash{$id} => name

You can specify a maximum number of rows to fetch by including a 'MaxRows' attribute in \%attr.

=cut

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

my %attr;
#my $sql = qq/select * from dict_dim where dim='acct'/;
#my $sql = qq/select id, type from dim_bi where id=?/;
#my @bind_values=qw/0/;

my $sql = qq/select id, type from dim_bi/;

# 1
# my @row = $dbh->selectrow_array($sql);
# 2
# my @row = $dbh->selectrow_array($sql, \%attr);
# 3
# my $row = $dbh->selectcol_arrayref($sql, \%attr, @bind_values);


my $row = $dbh->selectcol_arrayref($sql, { Columns => [1,2] });
my %hash = @$row ;

Data::Dump->dump(%hash);

# Data::Dump->dump( %attr );

$dbh->commit();
$dbh->disconnect();

