#!/usr/bin/perl


use strict;
use warnings;
use Data::Dump;
use Getopt::Long;

#########################################
# declare default values for variables
#########################################
# 三个变量的默认值都是空值''
my $data    = '';
my $length  = '';
my $verbose = '';

my $result  = GetOptions(
    "length=i" => \$length,    # numeric
    "file=s"   => \$data,      # string
    "verbose!" => \$verbose,   # flag	it also allowed to use --noverbose
    "verbose+" => \$verbose    # flag	Using --verbose on the command line
	                           # will increment the value of $verbose . This way the program can keep 
	                           # track of how	many times the option occurred on the command line. 
);

&usage unless ( $length && $data ) ;
#Data::Dump->dump($result);
#################################################################
    # test perl getopt1.pl --length 10 --data dat --verbose 2
    # test perl getopt1.pl -length 10 -data dat -verbose 2
#################################################################
if ($result) {
    print <<EOF;
length:		$length
file:		$data
verbose:	$verbose
EOF
}

sub usage {
    print <<EOF;
usage : getopt2.pl -length num -file filename -verbose
EOF
    exit 1;
}
