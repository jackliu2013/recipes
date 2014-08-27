#!/usr/bin/env perl

=comment

$hash_ref = $dbh->selectall_hashref($statement, $key_field);
$hash_ref = $dbh->selectall_hashref($statement, $key_field, \%attr);
$hash_ref = $dbh->selectall_hashref($statement, $key_field, \%attr, @bind_values);

This utility method combines "prepare", "execute" and "fetchall_hashref" into a single call. 
It returns a reference to a hash containing one entry, at most, for each row, as returned by fetchall_hashref().

The $statement parameter can be a previously prepared statement handle, in which case the prepare is skipped. 
This is recommended if the statement is going to be executed many times.

The $key_field parameter defines which column, or columns, are used as keys in the returned hash. It can 
either be the name of a single field, or a reference to an array containing multiple field names. Using multiple names 
yields a tree of nested hashes.

If a row has the same key as an earlier row then it replaces the earlier row.

If any method except fetchrow_hashref fails, and "RaiseError" is not set, selectall_hashref will return undef. If fetchrow_hashref 
fails and "RaiseError" is not set, then it will return with whatever data it has fetched thus far. $DBI::err should be checked to catch that.

See fetchall_hashref() for more details.

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

Data::Dump->dump($cfg);

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

# Data::Dump->dump( $dbh ) ;
my $key_field = 'id' ;
my $sql = "select * from dim_p";
my $href = $dbh->selectall_hashref( $sql, $key_field );

Data::Dump->dump( $href );

#foreach my $row (@$aref) {
#   print " ID: $row->{id}\t Name: $row->{name}\n";
#}

$dbh->commit();
$dbh->disconnect;
