
=comment 

  $DBI::err => error numer
  $DBI::errstr  => error message
  $DBI::state   => 

 this end, DBI defines several error diagnostic methods that can be invoked against any valid
 handle, driver, database, or statement. These methods will inform the programmer of the error code
 and report the verbose information from the last DBI method called. These are:
 $rv = $h->err();       # 返回错误的编码  error number
 $str = $h->errstr();   # 返回错误的信息  error message  
 $str = $h->state();
 These various methods return the following items of information that can be used for more accurate
 debugging of errors:
 • $h- >err() returns the error number that is associated with the current error flagged against
       the handle $h. The values returned will be completely dependent on the values produced by
       the underlying database system. Some systems may not support particularly meaningful
       information; for example, mSQL errors always have the error number of -1. Oracle is slightly
       more helpful: a connection failure may flag an ORA-12154 error message upon connection
       failure, which would return the value of 12154 by invoking $h->err(). Although this value is
       usually a number, you should not rely on that.
 • $h- >errstr() is a slightly more useful method, in that it returns a string containing a
       description of the error, as provided by the underlying database. This string should
       correspond to the error number returned in $h->err().
       For example, mSQL returns -1 as the error number for all errors, which is not particularly
       useful. However, invoking $h->errstr() provides far more useful information. In the case
       of connection failure, the error:
       ERROR : Can't connect to local MSQL server
       might be generated and returned by $h->errstr(). Under Oracle, a connection failure
       returning the error number of 12154 will return the following string as its descriptive error
       message:
       ORA-12154: TNS:could not resolve service name (DBD ERROR: OCIServerAttach)
 •$h- >state() returns a string in the format of the standard SQLSTATE five-character error
       string. Many drivers do not fully support this method, and upon invoking it to discern the
       SQLSTATE code, the value:
       S1000
       will be returned. The specific general success code 00000 is translated to 0, so that if no error
       has been flagged, this method will return a false value.
       The error information for a handle is reset by the DBI before most DBI method calls. Therefore, it's
       important to check for errors from one method call before calling the next method on the same
       handle. If you need to refer to error information later you'll need to save it somewhere else yourself.
       A rewriting of the previous example to illustrate using the specific handle methods to report on errors
       can be seen in the following code:

=cut

#!/usr/bin/perl -w
#
# ch04/error/ex3: Small example using manual error checking which also uses
# handle-specific methods for reporting on the errors.
use DBI;    # Load the DBI module

### Attributes to pass to DBI->connect() to disable automatic
### error checking
my %attr = (
    PrintError => 0,
    RaiseError => 0,
);

### Perform the connection using the Oracle driver
my $dbh = DBI->connect( "dbi:DB2:zdb_dev", "db2inst", "db2inst", \%attr )
  or die "Can't connect to database: ", $DBI::errstr, "\n";

### Prepare a SQL statement for execution
my $sth = $dbh->prepare("SELECT * FROM study.student")
  or die "Can't prepare SQL statement: ", $dbh->errstr(), "\n";

### Execute the statement in the database
$sth->execute or die "Can't execute SQL statement: ", $sth->errstr(), "\n";

### Retrieve the returned rows of data
while ( my @row = $sth->fetchrow_array() ) {
    print "Row: @row\n";
}
warn "Problem in fetchrow_array(): ", $sth->errstr(), "\n" if $sth->err();
### Disconnect from the database
$dbh->disconnect  or warn "Failed to disconnect: ", $dbh->errstr(), "\n";
exit;

