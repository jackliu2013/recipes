#!/usr/bin/env perl

##################################
#Options with hash values
##################################

use strict;
use warnings;
use Data::Dump;
use Getopt::Long;

# If the option destination is a reference to a hash, the option will take, 
# as value, strings of the form key= value. 
# The value will be stored with the specified key in the hash.

################ demo 1 ###############
=p
my %defines;
my @k;
my @v;
GetOptions ("define=s" => \%defines);
@k = keys %defines;
@v = values %defines;
print <<EOF;
define	:	@k	@v
EOF
=cut

# Alternatively you can use:
################ demo 2 ###############
my $defines;
GetOptions ("d|define=s%" => \$defines);
my @k = keys %{$defines};
my @v = values %{$defines};
print <<EOF;
define	:   @k	
define  :   @v
EOF

Data::Dump->dump( $defines );

# When used with command line options:
# --define os=linux --define vendor=redhat

# the hash %defines (or %$defines ) will contain two keys, 
# "os" with value "linux" and "vendor" with value "redhat" 

# It is also possible to specify that only integer or floating 
# point numbers are acceptable values. The keys are always taken to be strings
