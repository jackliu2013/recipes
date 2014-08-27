#!/usr/bin/perl

use strict;
use warnings;
use List::MoreUtils qw/firstidx first_index lastidx last_index
  insert_after insert_after_string apply indexes
  after after_incl before before_incl
  firstval first_value lastval last_value
  each_array each_arrayref pairwise natatime
  mesh zip uniq distinct minmax part/;

use Data::Dump;

############# demo 1 ############
#firstidx BLOCK LIST
#first_index BLOCK LIST
#Returns the index of the first element in LIST for which the criterion in BLOCK is true. Sets $_ for each item in LIST in turn:
#first_index is an alias for firstidx.
#my @list = ( 1, 4, 3, 2, 4, 6 );

#item with index 1 in list is 4
#Returns -1 if no such item could be found.
#printf "item with index %i in list is 4\n", firstidx { $_ == 4 } @list;

############# demo 2 ############
#lastidx BLOCK LIST
#last_index BLOCK LIST
#last_index is an alias for lastidx.
#Returns the index of the last element in LIST
#  for which the criterion in BLOCK is true . Sets $_
#  for each item in LIST in turn
#item with index 4 in list is 4
#Returns -1 if no such item could be found.

#@list = ( 1, 4, 3, 2, 4, 6 );
#printf "item with index %i in list is 4\n", lastidx { $_ == 4 } @list;

############# demo 3 ############
#insert_after BLOCK VALUE LIST
#Inserts VALUE after the first item in LIST
#for which the criterion in BLOCK is true
#. Sets $_
#for each item in LIST in turn
#This is a longer list
#@list = qw/This is a list/;
#insert_after { $_ eq "a" } "longer" => @list;
#print "@list\n";

############# demo 4 ############
#insert_after_string STRING VALUE LIST
#Inserts VALUE after the first item in LIST which is equal to STRING.
#This is a longer list

#@list = qw/This is a list/;
#insert_after_string "a", "longer" => @list;
#print "@list\n";

############# demo 5 ############
#apply BLOCK LIST
#Applies BLOCK to each item in LIST and returns a list of the values after BLOCK has been applied. In scalar context, the last element is returned. This function is similar to map but will not modify the elements of the input list:
#@list = 1 2 3 4
#@mult = 2 4 6 8
#Think of it as syntactic sugar for
#for (my @mult = @list) { $_ *= 2 }
#@list = ( 1 .. 4 );
#my @mult = apply { $_ *= 2 } @list;
#print "\@list = @list\n";
#print "\@mult = @mult\n";

############# demo 5 ############
#before BLOCK LIST
#Returns a list of values of LIST upto (and not including) the point where BLOCK returns a true value. Sets $_ for each element in LIST in turn.
#before_incl BLOCK LIST
#Same as before but also includes the element for which BLOCK is true.
#after BLOCK LIST
#Returns a list of the values of LIST after (and not including) the point where BLOCK returns a true value. Sets $_ for each element in LIST in turn.
#after_incl BLOCK LIST
#Same as after but also inclues the element for which BLOCK is true.

#my @x = before { $_ % 5 == 0 } ( 1 .. 9 );    # returns 1, 2, 3, 4
#print "@x\n";
#@x = before_incl { $_ % 5 == 0 } ( 1 .. 9 );    # returns 1, 2, 3, 4,5
#print "@x\n";
#@x = after { $_ % 5 == 0 } ( 1 .. 9 );          # returns 6, 7, 8, 9
#print "@x\n";
#@x = after_incl { $_ % 5 == 0 } ( 1 .. 9 );     # returns 5,6, 7, 8, 9
#print "@x\n";

#indexes BLOCK LIST
#Evaluates BLOCK for each element in LIST (assigned to $_) and returns a list ofthe indices of those elements for which BLOCK returned a true value. This is just like grep only that it returns indices instead of values:

#@x = indexes { $_ % 2 == 0 } ( 1 .. 10 );       # returns 1, 3, 5, 7, 9
#print @x, "\n";

#firstval BLOCK LIST
#first_value BLOCK LIST
#Returns the first element in LIST for which BLOCK evaluates to true. Each element of LIST is set to $_ in turn. Returns undef if no such element has been found.
#first_val is an alias for firstval.
#lastval BLOCK LIST
#last_value BLOCK LIST
#Returns the last value in LIST for which BLOCK evaluates to true. Each element of LIST is set to $_ in turn. Returns undef if no such element has been found.
#last_val is an alias for lastval.

#pairwise BLOCK ARRAY1 ARRAY2
#Evaluates BLOCK for each pair of elements in ARRAY1 and ARRAY2 and returns a new list consisting of BLOCK's return values. The two elements are set to $a and $b. Note that those two are aliases to the original value so changing them will modify the input arrays.

#my @a = ( 1 .. 5 );
#my @b = ( 11 .. 15 );
#@x = pairwise { $a + $b } @a, @b;    # returns 12, 14, 16, 18, 20
#my $aref = join( ',', @x );
#print $aref, "\n";

# mesh with pairwise
#@a = qw/a b c/;
#@b = qw/1 2 3/;
#@x = pairwise { ( $a, $b ) } @a, @b;    # returns a, 1, b, 2, c, 3
#print @x, "\n";

##each_array ARRAY1 ARRAY2 ...
#Creates an array iterator to return the elements of the list of arrays ARRAY1, ARRAY2 throughout ARRAYn in turn. That is, the first time it is called, it returns the first element of each array. The next time, it returns the second elements. And so on, until all elements are exhausted.
#This is useful for looping over more than one array at once:
#The iterator returns the empty list when it reached the end of all arrays.
#If the iterator is passed an argument of 'index', then it retuns the index of the last fetched set of values, as a scalar.
#each_arrayref LIST
#Like each_array, but the arguments are references to arrays, not the plain arrays.

#my @a = qw/1 2 3 4 5/;
#my @b = qw/1 2 3 4 5/;
#my @c = qw/1 2 3 4 5/;

#my $ea = each_array( @a, @b, @c );
#while ( my ( $a, $b, $c ) = $ea->() ) {
#    Data::Dump->dump($a,$b,$c);
#}

#natatime EXPR, LIST
#Creates an array iterator, for looping over an array in chunks of $n items at a time. (n at a time, get it?). An example is probably a better explanation than I could give in words.
#Example:
#my @x = ( 'a' .. 'g' );
#my $it = natatime 3, @x;
#while ( my @vals = $it->() ) {
#    print "@vals\n";
#}
#    This prints
#
#        a b c
#        d e f
#        g

#mesh ARRAY1 ARRAY2 [ ARRAY3 ... ]
#zip ARRAY1 ARRAY2 [ ARRAY3 ... ]
#zip is an alias for mesh.
#Returns a list consisting of the first elements of each array, then the second, then the third, etc, until all arrays are exhausted.
#    Examples:
#my @x    = qw/a b c d/;
#my @y    = qw/1 2 3 4/;
#my @z    = mesh @x, @y;       # returns a, 1, b, 2, c, 3, d, 4
#my $aref = join( ',', @z );
#print $aref, "\n";

#my @a = ('x');
#my @b = ('1', '2');
#my @c = qw/zip zap zot/;
#my @d = mesh @a, @b, @c;   # x, 1, zip, undef, 2, zap, undef, undef, zot
#my $aref = join( ',', @d );
#print $aref, "\n";

#uniq LIST
#distinct LIST
#Returns a new list by stripping duplicate values in LIST. The order of elements in the returned list is the same as in LIST. In scalar context, returns the number of unique elements in LIST.
#
#my @x = uniq 1, 1, 2, 2, 3, 5, 3, 4;    # returns 1 2 3 5 4
#rint @x, "\n";
#y $x = uniq 1, 1, 2, 2, 3, 5, 3, 4;    # returns 5
#rint $x, "\n";

#minmax LIST
#Calculates the minimum and maximum of LIST and returns a two element list with the first element being the minimum and the second the maximum. Returns the empty list if LIST was empty.
#The minmax algorithm differs from a naive iteration over the list where each element is compared to two values being the so far calculated min and max value in that it only requires 3n/2 - 2 comparisons. Thus it is the most efficient possible algorithm.
#However, the Perl implementation of it has some overhead simply due to the fact that there are more lines of Perl code involved. Therefore, LIST needs to be fairly big in order for minmax to win over a naive implementation. This limitation does not apply to the XS version.

#part BLOCK LIST
#Partitions LIST based on the return value of BLOCK which denotes into which partition the current value is put.
#Returns a list of the partitions thusly created. Each partition created is a reference to an array.
#my $i = 0;
#my @part = part { $i++ % 2 } 1 .. 8;    # returns [1, 3, 5, 7], [2, 4, 6, 8]
#Data::Dump->dump(@part);

#You can have a sparse list of partitions as well where non-set partitions will be undef:
#my @part = part { 2 } 1 .. 10;    # returns undef, undef, [ 1 .. 10 ]
#Data::Dump->dump(@part);

#Be careful with negative values, though:
#my @part = part { -1 } 1 .. 10;
#Data::Dump->dump(@part);
#Modification of non-creatable array value attempted, subscript -1 ...

#Negative values are only ok when they refer to a partition previously created:
my @idx  = ( 0, 1, -1 );
my $i    = 0;
my @part = part { $idx[$i++ % 3] } 1 .. 8; # [1, 4, 7], [2, 3, 5, 6, 8]
Data::Dump->dump(@part);


