#!/usr/bin/perl

=comment

@row_ary = $dbh->selectrow_array($statement);
@row_ary = $dbh->selectrow_array($statement, \%attr);
@row_ary = $dbh->selectrow_array($statement, \%attr, @bind_values);

This utility method combines "prepare", "execute" and "fetchrow_array" into a single call. 
If called in a list context, it returns the first row of data from the statement. 
The $statement parameter can be a previously prepared statement handle, in which case the prepare is skipped.

If any method fails, and "RaiseError" is not set, selectrow_array will return an empty list.

If called in a scalar context for a statement handle that has more than one column, 
it is undefined whether the driver will return the value of the first column or the last. 
So don't do that. Also, in a scalar context, an undef is returned if there are no more rows 
or if an error occurred. That undef can't be distinguished from an undef returned because the first field value was NULL. 
For these reasons you should exercise some caution if you use selectrow_array in a scalar context, or just don't do that.

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
my $sql         = qq/select * from dict_dim where dim=?/;
my @bind_values = qw/period/;

# 1
# my @row = $dbh->selectrow_array($sql);

# 2
# my @row = $dbh->selectrow_array($sql, \%attr);

# 3
my @row = $dbh->selectrow_array( $sql, \%attr, @bind_values );

# Data::Dump->dump(@row);
printf "@row\n";

# Data::Dump->dump( %attr );

$dbh->commit();
$dbh->disconnect();

