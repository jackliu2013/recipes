#!/usr/bin/env perl

use strict;
use warnings;
use DBI;
use Carp;

use Data::Dump;

my $db_cfg = {
    dsn    => 'dbi:DB2:zdb_dev',
    user   => 'db2inst',
    pwd    => 'db2inst',
    schema => 'study',
};

# dbh database handle object
my $dbh = DBI->connect(
    @{$db_cfg}{qw/dsn user pwd/},
    {
        RaiseError => 1,
        AutoCommit => 0,
    }
);

=comment

典型的 select 语句的操作
The typical method call sequence for a SELECT statement is:

prepare,
      execute, fetch, fetch, ...
      execute, fetch, fetch, ...
      execute, fetch, fetch, ...
=cut

# sth statement handle object
my $sth = $dbh->prepare(qq/insert into study.student(id, name) values ( ?,?)/);
my $id = '0100' ;
my $name = 'test' ;

$sth->execute( $id, $name ) ;

$sth->finish();
$dbh->commit();
$dbh->disconnect();
