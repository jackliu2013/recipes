#!/usr/bin/perl
use strict;
use warnings;

use List::MoreUtils qw{any all none notall true false
  firstidx first_index lastidx last_index	insert_after insert_after_string
  apply indexes after after_incl before before_incl firstval first_value
  lastval last_value each_array each_arrayref pairwise natatime
  mesh zip uniq distinct minmax part
};

=any BLOCK LIST Returns a true value if any item in LIST meets the criterion given 
through BLOCK. Sets $_ for each item in LIST in turn:
Returns false otherwise, or if LIST is empty.
=cut

########### demo 1 ##########
#my @list = ( 1, 2, undef, 3, 4 );
#my @list = ( 1, 2, 5, 3, 4 );
#print "At least one value undefined\n" if any { !defined($_) } @list;

=all BLOCK LIST
Returns a true value if all items in LIST meet the criterion given
through BLOCK, or if LIST is empty. Sets $_ for each item in LIST in turn:
Returns false otherwise
=cut

########### demo 2 ##########
#my @list = qw/hello world/;
#my @list = ( 'hello', 'world', undef );
#rint "All items defined\n" if all { defined($_) } @list;

=none BLOCK LIST
Logically the negation of any. Returns a true value if no item in 
LIST meets the criterion given through BLOCK, or if LIST is empty.
Sets $_ for each item in LIST in turn:
Returns false otherwise.
=cut

########### demo 3 ##########
#my @list = qw//;	# @list is empty
#my @list = qw/hello/;	# @list is not empty
#print "No value defined\n" if none { defined($_) } @list;

=notall BLOCK LIST
Logically the negation of all. Returns a true value if not all items
in LIST meet the criterion given through BLOCK. Sets $_ for each item 
in LIST in turn:
Returns false otherwise, or if LIST is empty.
=cut

########### demo 4 ##########
#my @list = ( "hello", undef, "world" );
#my @list = ( "hello", "world" );
#print "Not all values defined\n" if notall { defined($_) } @list;

=true BLOCK LIST
Counts the number of elements in LIST for which the criterion in BLOCK 
is true. Sets $_ for each item in LIST in turn:
=cut

########### demo 5 ##########
#my @list = qw/hello world/ ;
#my @list = ( 'hello', undef, 'world' );
#printf "%i item(s) are defined\n", true { defined($_) } @list;

=false BLOCK LIST
Counts the number of elements in LIST for which the criterion in BLOCK 
is false. Sets $_ for each item in LIST in turn:
=cut

########### demo 6 ##########
my @list = qw//;
$list[9] = "love";
printf "%i item(s) are not defined\n", false { defined($_) } @list;

