#!/usr/bin/env perl

=comment

The DBI supports a utility method called dump_results( ) for fetching all of the rows in a statement
handle's result set and printing them out. This method is invoked via a prepared and executed
statement handle, and proceeds to fetch and print all the rows in the result set from the database. As
each line is fetched, it is formatted according either to default rules or to rules specified by you in your
program. Once dump_results( ) has finished executing, it prints the number of rows fetched from
the database and any error message. It then returns with the number of rows fetched.
For example, to quickly display the results of a query, you can write:

=cut


use strict;
use warnings;
use DBI;

my $cfg = {
    dsn    => "dbi:DB2:$ENV{DB_NAME}",
    user   => "$ENV{DB_USER}",
    pass   => "$ENV{DB_PASS}",
    schema => "$ENV{DB_SCHEMA}",
};

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

# my $sql = "select * from dim_p";
my $sql = q/select * from study.student/;
my $sth = $dbh->prepare( $sql );

$sth->execute();

my $rows = $sth->dump_results();

print "$rows\n";

$dbh->commit();
$dbh->disconnect;
