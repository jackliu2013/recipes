#!/usr/bin/env perl

=comment

We discussed in Chapter 3 the various data manipulation techniques that you might wish to use on
your data. So far in this chapter, we have discussed the most commonly used data manipulation
operation, fetching. But what about inserting, deleting, and updating data?
These operations are treated somewhat differently than querying, as they do not use the notion of a
cursor to iterate through a result set. They simply affect rows of data stored within tables without
returning any rows to your programs. As such, the full prepare-execute-fetch-deallocate cycle is not as
appropriate for these operations. The fetch stage simply doesn't apply.
Since you're usually going to invoke these statements only once, it would be very tiresome to have to
call prepare( ) to get a statement handle and then call execute( ) on that statement handle to
actually invoke it, only to immediately discard that statement handle.
Fortunately, the DBI defines a shortcut for carrying out these operations - the do( ) method, invoked
against a valid database handle. Using do( ) is extremely easy. For example, if you wished to delete
some rows of data from the megaliths table, the following code is all that's required:

### Assuming a valid database handle exists....
### Delete the rows for Stonehenge!
    $rows = $dbh->do( "
        DELETE FROM megaliths
        WHERE name = 'Stonehenge'
        " );

To signify whether or not the SQL statement has been successful, a value is returned from the call
signifying either the number of rows affected by the SQL statement, or undef if an error occurred.
Some databases and some statements will not be able to return the number of rows affected by some
statements; -1 will be returned in these cases.

As a special case, a row count of zero is returned as the string 0E0, which is just a fancy mathematical
way of saying zero. Returning 0E0 instead of 0 means that the do( ) method still returns a value that
Perl interprets as true, even when no rows have been affected.[5] The do( ) method returns a false
value only on an error.


=cut


use strict;
use warnings;

use DBI;

my $dbh = DBI->connect("dbi:DB2:sample", "db2inst", "db2inst",
            {
                AutoCommit => 0,
                PrintError => 0,
                RaiseError => 1,
            } ) ;

eval {
    my $rows = $dbh->do(q/insert into act(actno, actkwd, actdesc) values ( '180', 'my doc', 'my document')/) ;
    print "commit the transcations begin\n" ; 
    $dbh->commit();
};

if ( $@ ) {
    warn "cannot commit the transactions";
    warn "error:$DBI::err";
    $dbh->rollback;
}


$dbh->rollback;
$dbh->disconnect ;
