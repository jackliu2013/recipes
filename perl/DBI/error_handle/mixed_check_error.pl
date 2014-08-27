#!/usr/bin/perl -w
#
# ch04/error/mixed1: Example showing mixed error checking modes.
use DBI;

# Load the DBI module
### Attributes to pass to DBI->connect() to disable automatic
### error checking
my %attr = (
    PrintError => 0,
    RaiseError => 0,
);

### The program runs forever and ever and ever and ever ...
while (1) {
      my $dbh;
    ### Attempt to connect to the database. If the connection
    ### fails, sleep and retry until it succeeds ...
      until (
          $dbh = DBI->connect( "dbi:DB2:zdb_dev", "db2inst", "db2inst", \%attr )
        )
      {
          warn "Can't connect: $DBI::errstr. Pausing before retrying.\n";
          sleep( 5 * 60 );
      }
      eval {    ### Catch _any_ kind of failures from the code within
          ### Enable auto-error checking on the database handle
          $dbh->{RaiseError} = 1;
          ### Prepare a SQL statement for execution
          my $sth = $dbh->prepare("SELECT stock, value FROM current_values");
          while (1) {
              ### Execute the statement in the database
              $sth->execute();
              ### Retrieve the returned rows of data
              while ( my @row = $sth->fetchrow_array() ) {
                      print "Row: @row\n";
                }
              ### Pause for the stock market values to move
              sleep 60;
          }
      };
      warn "Monitoring aborted by error: $@\n" if $@;
### Short sleep here to avoid thrashing the database
      sleep 5;
}
exit;

