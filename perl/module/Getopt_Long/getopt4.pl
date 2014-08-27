#!/usr/bin/env perl

###################################
# Options with multiple values
# 带有多个参数的命令参数选项
###################################

use strict;
use warnings;
use Getopt::Long;
use Data::Dump;

# Options sometimes take several values. For example, a program could use multiple directories to search for library files:
#    --library lib/stdlib --library lib/extlib
# To accomplish this behaviour, simply specify an array reference as the destination for the option:
#    GetOptions ("library=s" => \@libfiles);
# Alternatively, you can specify that the option can have multiple values by adding a "@", and pass a scalar reference as the destination:
#    GetOptions ("library=s@" => \$libfiles);


# Used with the example above, @libfiles (or @$libfiles ) would contain two strings upon completion: "lib/srdlib" and "lib/extlib" ,
# in that order. It is also possible to specify that only integer or floating point numbers are acceptable values.
# Often it is useful to allow comma-separated lists of values as well as multiple occurrences of the options. This is easy using Perl's split() and join() operators:

############## demo 1 ###################
# called this demo 
# ./getopt4.pl -library /lib -library /usr/lib
# test -library lib/mylib -library lib/stdlib

#my @libfiles = '';
#GetOptions( "library=s@" => \@libfiles );
#@libfiles = split( /,/, join( ',', @libfiles ) );
#print <<EOF;
#library:	@libfiles
#EOF

############## demo 2 ###################
# test -library 'lib/mylib lib/stdlib'
# test -l "lib/mylib lib/stdlib"
my $libfiles;
GetOptions( "library|l=s@" => \$libfiles );
print <<EOF;
library:	@$libfiles
EOF

# Of course, it is important to choose the right separator string for each purpose.
# Warning: What follows is an experimental feature.
# Options can take multiple values at once, for example
# --coordinates 52.2 16.4 --rgbcolor 255 255 149
# This can be accomplished by adding a repeat specifier to the option specification. 
# Repeat specifiers are very similar to the {...} repeat specifiers that can be used with regular expression patterns. 
# For example, the above command line would be handled as follows:

############## demo 3 ###################
# called this demo 
# ./getopt4.pl -coordinates 20.0 21.2 -rgbcolor 121 188 200
# my @coor;
# my @color;
# # 获取两个浮点数坐标，三个整数RGB
# GetOptions( 'coordinates=f{2}' => \@coor, 'rgbcolor=i{3}' => \@color );
# 
# print <<EOF;
#     coordinates:	@coor
#     rgbcolor   :	@color
# EOF

# The destination for the option must be an array or array reference.

# It is also possible to specify the minimal and maximal number of arguments an option takes. foo=s{2,4} indicates an option
# that takes at least two and at most 4 arguments. foo=s{,} indicates one or more values; foo:s{,} indicates zero or more option values.

sub usage {
    print <<EOF;
usage : ./getopt4.pl --library
EOF
    exit -1;
}

