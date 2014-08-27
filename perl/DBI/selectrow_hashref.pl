#!/usr/bin/perl

=comment

$hash_ref = $dbh->selectrow_hashref($statement);
$hash_ref = $dbh->selectrow_hashref($statement, \%attr);
$hash_ref = $dbh->selectrow_hashref($statement, \%attr, @bind_values);

This utility method combines "prepare", "execute" and "fetchrow_hashref" into a single call. 
It returns the first row of data from the statement. The $statement parameter can be a previously 
prepared statement handle, in which case the prepare is skipped.

If any method fails, and "RaiseError" is not set, selectrow_hashref will return undef.

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
my $sql = qq/select * from dict_dim where dim=?/;
my @bind_values=qw/period/;

# 1
# my @row = $dbh->selectrow_array($sql);

# 2
# my @row = $dbh->selectrow_array($sql, \%attr);

# 3
my $row = $dbh->selectrow_hashref($sql, \%attr, @bind_values);

Data::Dump->dump($row);

# Data::Dump->dump( %attr );

$dbh->commit();
$dbh->disconnect();

