
=comment

neat and tidy formatting 字符串整理
The DBI features a couple of utility functions that can be used to tidy up strings into a form suitable
for easy reading. These two functions are neat() and neat_list() , the former operating on a single
scalar value, the latter operating on a list of scalar values.
For example, to use neat() to tidy up some strings, you could write:

While the neat() function is handy for single values, the neat_list() function is handy for lists. It
simply calls neat() on each element of the referenced list before joining the list of values together
with the desired separator string. For example:


=cut

#!/usr/bin/perl -w
#
# ch04/util/neat1: Tests out the DBI::neat() utility function.
#
use DBI qw/neat_list/;

### Declare some strings to neatify
my $str1 = "Alligator's an extremely neat() and tidy person";
my $str2 = "Oh no\nhe's not!";

### Neatify this first string to a maxlen of 40
print "String: " . DBI::neat( $str1, 40 ) . "\n";

### Neatify the second string to a default maxlen of 400
print "String: " . DBI::neat($str2) . "\n";


### Neatify a number
print "Number: " . DBI::neat( 42 * 9 ) . "\n";

### Neatify an undef
print "Undef: " . DBI::neat( undef ) . "\n";


=comment

which generates the output of:

String: 'Alligator's an extremely neat() and...'
String: 'Oh no 
he's not!'
Number: 378
Undef: undef

=cut


### Declare some strings to neatify
my @list = ( 'String-a-string-a-string-a-string-a-string', 42, 0, '', undef );

### Neatify the strings into an array
print neat_list( \@list, 40, ", " ), "\n";

exit;

=comment

which generates the output of:

'String-a-string-a-string-a-string-a...', 42, 0, '', undef

=cut
