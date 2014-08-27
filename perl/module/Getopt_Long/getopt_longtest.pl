#!/usr/bin/env perl
use Getopt::Long;
use Data::Dump;
use strict;
use warnings;

# declare default values for variables
my @arr = @ARGV ;
my $verbose = 0;
my $all     = 0;
my $more    = -1;       # so we can detect both -more and -nomore
my $diam    = 3.1415;
my @libs    = ();
my %flags   = ();
my $debug   = -1;       # test for -debug with no argument (0)

# process options from command line
GetOptions(
    'verbose+'                => \$verbose, # verbose will be incremented each time it appears
    'all|everything|universe' => \$all,     # either all, everything or universe will set $all to 1
    'more!'                   => \$more,    # A negatable option is specified with an exclamation 
    'd|diameter=f'            => \$diam,    # diameter expects a floating point argument
    'l|lib=s'                 => \@libs,    # lib expects a string and can be repeated (pushing onto @libs)
    'f|flag=s'                => \%flags,   # flag expects a key=value pair and can be repeated
    'debug:i'                 => \$debug    # debug will optionally accept an integer (or 0 by default)
);

Data::Dump->dump( %flags );

# display resulting values of variables
print <<EOF;
verbose:        $verbose
all:            $all
more:           $more
diameter:       $diam
debug:          $debug
libs:           @{[ join ',', @libs ]}
flags:          @{[ join "\n", map { $_ } each %flags ]}

Remaining:      @{[ join ',', @ARGV ]}
(ARGV contents): @arr
EOF

#######################################################################
###
# the commandline
#perl Getopt_LongTest.pl -l abc -l def -f a=b -f b=c -ev -de 5 -nomore arg

######################################################################
###
#
=head the result
Verbose:        0
All:            1
More:           0
Diameter:       3.1415
Debug:          5
Libs:           abc,def
Flags:          a = b
		b = c

Remaining:      arg
  (ARGV contents) : @arr
=cut
