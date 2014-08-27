#!/usr/bin/perl -w

=comment
At the highest level, you can call the DBI- >trace() method, which enables tracing on all DBI
operations from that point onwards. There are several valid tracing levels:
0   Disables tracing.
1   Traces DBI method execution showing returned values and errors.
2   As for 1, but also includes method entry with parameters.
3   As for 2, but also includes more internal driver trace information.
4   Levels 4, and above can include more detail than is helpful.

The trace() method can be used with two argument forms, either specifying only the trace level or
specifying both the trace level and a file to which the trace information is appended. The following
example shows the use of DBI->trace():

=cut

#
# ch04/util/trace1: Demonstrates the use of DBI tracing.
use DBI;    

### Remove any old trace files
unlink 'dbitrace.log' if -e 'dbitrace.log';

### Connect to a database
my $dbh = DBI->connect( "dbi:DB2:zdb_dev", "db2inst", "db2inst" );

### Set the tracing level to 1 and prepare()
DBI->trace(1);
&doPrepare();

### Set trace output to a file at level 2 and prepare()
DBI->trace( 2, 'dbitrace.log' );
&doPrepare();

### Set the trace output back to STDERR at level 2 and prepare()
DBI->trace( 2, undef );
&doPrepare();

exit;

### prepare a statement (invalid to demonstrate tracing)
sub doPrepare {
    print "Preparing and executing statement\n";
    my $sth = $dbh->prepare( "SELECT * FROM study.student" );
    $sth->execute();
    return;
}
exit;

