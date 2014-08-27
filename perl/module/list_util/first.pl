#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(first max maxstr min minstr reduce shuffle sum);

########################first LIST######################
my @list = qw/hello world baby/;
print "begin test first func in List::Util\n";
# first defined value in @list
my $foo = first { defined($_) } @list ;
print "$foo\n";		#print hello

@list = qw/1 2 3 4 5/;
my $value = 3 ;
# first value in @list which is greater than $value
$foo = first { $_ > $value } @list ;
print "$foo\n";
print "end test first func in List::Util\n\n";

########################max LIST######################
print "begin test max func in List::Util\n";
my (@bar,@baz);
$foo = max 1..10 ;	# 10
print "$foo\n";

$foo = max 3,9,12 ;	# 12
print "$foo\n";

$foo = max @bar, @baz ;	# whatever
print "$foo\n";
print "end test max func in List::Util\n\n";

########################maxstr LIST######################
print "begin test maxstr func in List::Util\n\n";
@bar=qw/thank you/;
@baz=qw/think yp/;
$foo = maxstr 'A'..'Z' ;	# 'Z'
print "$foo\n";

$foo = maxstr "hello","world";	# "world"
print "$foo\n";

$foo = maxstr @bar, @baz ;	# whatever
print "$foo\n";
print "end test maxstr func in List::Util\n\n";

########################min LIST######################
print "begin test min func in List::Util\n\n";
@bar = qw/6 5 4/;
@baz = qw/8 9 1/;
$foo = min 1..10;	# 1
print "$foo\n";

$foo = min 3,9,12;      # 3
print "$foo\n";

$foo = min @bar, @baz;	# whatever
print "$foo\n";

print "end test min func in List::Util\n\n";


########################minstr LIST######################
print "begin test minstr func in List::Util\n\n";
@bar = qw/hello world/;
@baz = qw/hello baby/;

$foo = minstr 'A'..'Z' ;         # 'A'
print "$foo\n";

$foo = minstr "hello","world" ;  # "hello"
print "$foo\n";

$foo = minstr @bar, @baz ;       # whatever
print "$foo\n";
print "end test minstr func in List::Util\n\n";

########################reduce BLOCK LIST######################
=reduce
Reduces LIST by calling BLOCK, in a scalar context, multiple times,
setting $a and $b each time. The first call will be with $a and $b
set to the first two elements of the list, subsequent calls will be
done by setting $a to the result of the previous call and $b to the
next element in the list.

Returns the result of the last call to BLOCK. If LIST is empty then
"undef" is returned. If LIST only contains one element then that
element is returned and BLOCK is not executed.
=cut
print "begin test reduce func in List::Util\n\n";
@bar=qw/hello world/;
my @values;
$foo = reduce { $a < $b ? $a : $b } 1..10 ;     # min	print 1
print "$foo\n";

$foo = reduce { $a lt $b ? $a : $b } 'aa'..'zz';# minstr	print aa
print "$foo\n";

$foo = reduce { $a + $b } 1 .. 10 ;             # sum	print 55
print "$foo\n";

$foo = reduce { $a . $b } @bar ;                # concat 
print "$foo\n";

$foo = reduce { $a + $b } 0, @values;          # sum with 0 identity value
print "$foo\n";
print "end test reduce func in List::Util\n\n";

########################shuffle	LIST######################
=shuffle LIST
Returns the elements of LIST in a random order
=cut
print "begin test shuffle func in List::Util\n\n";
my @cards = shuffle 0..51 ;    # 0..51 in a random order
print "@cards\n";
print "end test shuffle func in List::Util\n\n";

########################sum	LIST######################
=sum LIST
Returns the sum of all the elements in LIST. If LIST is empty then
"undef" is returned.
=cut

print "begin test sum func in List::Util\n\n";
@bar = qw/100 200 300/;
@baz = qw/200 100 300/;
$foo = sum 1..10 ;              # 55
print "$foo\n";

$foo = sum 3,9,12;              # 24
print "$foo\n";

$foo = sum @bar, @baz ;         # whatever
print "$foo\n";
print "end test sum func in List::Util\n\n";

########################sum0	LIST######################
=sum0 LIST
Similar to "sum", except this returns 0 when given an empty list,
rather than "undef".
=cut
