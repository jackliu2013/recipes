#!/usr/bin/env perl

use strict;
use warnings;

use DBI;

=comment

These attributes are common to all types of DBI handles.

Some attributes are inherited by child handles. That is, the value of an inherited attribute in a newly created statement handle is the same as the value in the parent database handle. Changes to attributes in the new statement handle do not affect the parent database handle and changes to the database handle do not affect existing statement handles, only future ones.

Attempting to set or get the value of an unknown attribute generates a warning, except for private driver specific attributes (which all have names starting with a lowercase letter).

Example:

  $h->{AttributeName} = ...;    # set/write
    ... = $h->{AttributeName};    # get/read



Kids

    Type: integer, read-only
    For a driver handle, Kids is the number of currently existing database handles that were created from that driver handle. For a database handle, Kids is the number of currently existing statement handles that were created from that database handle. For a statement handle, the value is zero.

ActiveKids
    Type: integer, read-only
    Like Kids, but only counting those that are Active (as above).

=cut

my $dbh = DBI->connect("dbi:DB2:zdb_dev", "db2inst", "db2inst");

warn "$dbh\n";
my $sth = $dbh->prepare(q/select * from study.student/);
# 
my $count1 = $dbh->{Kids} ;
my $count2 = $dbh->{ActiveKids} ;

print "所有的连接数：$count1\n";
print "所有激活的连接数：$count2\n";

$sth->finish ;
$dbh->disconnect;
