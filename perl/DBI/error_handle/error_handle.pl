#!/usr/bin/env perl

use strict;
use warnings;
use DBI;

### Perform the connection using the Oracle driver
my $dbh = DBI->connect(
    'dbi:DB2:zdb_dev',
    "db2inst",
    "db2inst",
    {
        PrintError => 0,
        RaiseError => 0
    }
) or die "Can't connect to the database: $DBI::errstr\n";

### Prepare a SQL statement for execution
my $sth = $dbh->prepare("SELECT * FROM megaliths")
  or die "Can't prepare SQL statement: $DBI::errstr\n";

### Execute the statement in the database
$sth->execute
  or die "Can't execute SQL statement: $DBI::errstr\n";

### Retrieve the returned rows of data
my @row;
while ( @row = $sth->fetchrow_array() ) {
    print "Row: @row\n";
}

warn "Data fetching terminated early by error: $DBI::errstr\n"
  if $DBI::err;

### Disconnect from the database
$dbh->disconnect
  or warn "Error disconnecting: $DBI::errstr\n";
exit;

