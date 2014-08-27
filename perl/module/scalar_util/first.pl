#!/usr/bin/perl

use strict;
use warnings;

use Scalar::Util qw(blessed dualvar isweak readonly refaddr reftype tainted	weaken isvstring looks_like_number set_prototype);
# and other useful utils appearing below

#######################blesseed test######################
=blessed EXPR
If EXPR evaluates to a blessed reference the name of the package that it is blessed into is returned. Otherwise undef is returned.
=cut
print "begin blessed EXPR test\n";
my $scalar = "foo";
my $class = blessed $scalar; # undef
print "$class\n";

my $ref = [];
$class = blessed $ref; # undef
print "$class\n";

my $obj = bless [], "Foo";
$class = blessed $obj; # "Foo"
print "$class\n";
print "end blessed EXPR test\n\n";

#######################dualvar test#####################
=dualvar NUM, STRING
Returns a scalar that has the value NUM in a numeric context and the value STRING in a string context.
=cut
print "begin dualvar test\n\n";
my $foo = dualvar 10, "Hello";
my $num = $foo + 2; # 12
print "$num\n";
my $str = $foo . " world"; # Hello world
print "$str\n";
print "end dualvar test\n\n";

#######################isweak test#####################
=isweak EXPR
If EXPR is a scalar which is a weak reference the result is true.
=cut

$ref = \$foo;
my $weak = isweak($ref); # false
print "$weak\n";

weaken($ref);
$weak = isweak($ref); # true
print "$weak\n";


#NOTE: Copying a weak reference creates a normal, strong, reference.
my $copy = $ref;
$weak = isweak($copy); # false
print "$weak\n";

