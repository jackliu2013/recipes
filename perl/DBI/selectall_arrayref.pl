#!/usr/bin/env perl

=comment

$ary_ref = $dbh->selectall_arrayref($statement);
$ary_ref = $dbh->selectall_arrayref($statement, \%attr);
$ary_ref = $dbh->selectall_arrayref($statement, \%attr, @bind_values);

This utility method combines "prepare", "execute" and "fetchall_arrayref" into a single call. 
It returns a reference to an array containing a reference to an array (or hash, see below) for each row of data fetched.

The $statement parameter can be a previously prepared statement handle, in which case the prepare is skipped. 
This is recommended if the statement is going to be executed many times.

If "RaiseError" is not set and any method except fetchall_arrayref fails then selectall_arrayref will return undef; 
if fetchall_arrayref fails then it will return with whatever data has been fetched thus far. You should check $dbh->err 
afterwards (or use the RaiseError attribute) to discover if the data is complete or was truncated due to an error.

The "fetchall_arrayref" method called by selectall_arrayref supports a $max_rows parameter. You can specify a value 
for $max_rows by including a 'MaxRows' attribute in \%attr. In which case finish() is called for you after fetchall_arrayref() returns.

The "fetchall_arrayref" method called by selectall_arrayref also supports a $slice parameter. You can specify a value 
for $slice by including a 'Slice' or 'Columns' attribute in \%attr. The only difference between the two is that if Slice is not 
defined and Columns is an array ref, then the array is assumed to contain column index values (which count from 1), rather than 
perl array index values. In which case the array is copied and each value decremented before passing to /fetchall_arrayref.

You may often want to fetch an array of rows where each row is stored as a hash. That can be done simple using:

my $emps = $dbh->selectall_arrayref( "SELECT ename FROM emp ORDER BY ename",{ Slice => {} } );
foreach my $emp ( @$emps ) {
    print "Employee: $emp->{ename}\n";
}

Or, to fetch into an array instead of an array ref:

@result = @{ $dbh->selectall_arrayref($sql, { Slice => {} }) };
See "fetchall_arrayref" method for more details.


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
my $sql = "select * from dim_p";
my $aref = $dbh->selectall_arrayref( $sql, { Slice => {} } );

Data::Dump->dump( $aref );

#foreach my $row (@$aref) {
#   print " ID: $row->{id}\t Name: $row->{name}\n";
#}

$dbh->commit();
$dbh->disconnect;
