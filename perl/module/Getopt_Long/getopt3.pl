#!/usr/bin/env perl

######################
# options with values
######################
# For options that take values it must be specified whether the option value is required or not, and what kind of value the option expects.
# Three kinds of values are supported: integer numbers, floating point numbers, and strings.
# If the option value is required, Getopt::Long will take the command line argument that follows the option and assign this to the option variable. If, however, the option value is specified as optional, this will only be done if that value does not look like a valid command line option itself.

use strict;
use warnings;
use Getopt::Long;

#my $tag = '';	# option variable with default value
#my $count=0;
#my $value=0;

my ( $tag, $count, $value );
my $result = GetOptions(
    'tag=s'   => \$tag,
    'count=i' => \$count,
    'value=f' => \$value,
);

#In the option specification, the option name is followed by an equals sign = and the letter s. The equals sign indicates that this option requires a value. The letter s indicates that this value is an arbitrary string. Other possible value types are i for integer values, and f for floating point values. Using a colon : instead of the equals sign indicates that the option value is optional. In this case, if no suitable value is supplied, string valued options get an empty string '' assigned, while numeric options are set to 0 .

=comment
如上面所说，
=说明该选项需要值 
:说明该选项的值是可选的,如果选项没有合适的值,
	string类型的默认值是empty string ''
	numeric类型的默认值是0
    s说明值是string
    i说明值是integer values
    f说明值是floating point values
=cut

&usage unless ($result);

    print <<EOF;
tag:	$tag
count:  $count
value:  $value
EOF

sub usage {
    print <<EOF;
usage : ./getopt3.pl tag=string count=i value=f
EOF
    exit -1;
}
