#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my %people = (
    'name' => 'ray',
    'age' => 24,
    'sex' => 'man',
    'food' => ['egg', 'apple'],
);

# See Data::Dumper module to get the default vaule of the 
# following module gobal variable. You can overwrite the
# default value to user defined one.

print "Show perl hash, with pre-defined variable name\n ";
print "and without maxdepth\n";
$Data::Dumper::Terse = 0; # default is 0
$Data::Dumper::Indent = 3; # default is 2
$Data::Dumper::Maxdepth = 0; # default is 0
my $variable_name = '*' . "my_info";
print Data::Dumper->Dump([\%people], [$variable_name]);

print "Show perl hash, without pre-defined variable name\n ";
print "and with maxdepth is 1\n";
$Data::Dumper::Terse = 1; # default is 0
$Data::Dumper::Indent = 2; # default is 2
$Data::Dumper::Maxdepth = 1; # default is 0
$variable_name = '$' . "my_info";
print Data::Dumper->Dump([\%people], [$variable_name]);
