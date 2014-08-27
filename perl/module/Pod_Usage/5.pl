#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
my $man  = 0;
my $help = 0;
## Parse options and print usage if there is a syntax error,
## or if usage was explicitly requested.
GetOptions( 'help|?' => \$help, man => \$man ) or pod2usage(2);
pod2usage(1) if $help;
pod2usage( -verbose => 2 ) if $man;
## If no arguments were given, then allow STDIN to be used only
## if it's not connected to a terminal (otherwise print usage)
pod2usage("$0: No files given.") if ( ( @ARGV == 0 ) && ( -t STDIN ) );
__END__

=head1 NAME
sample - Using GetOpt::Long and Pod::Usage
=head1 SYNOPSIS
sample [options] [file ...]
Options:
-help brief help message
-man full documentation
=head1 OPTIONS
=over 8
=item B<-help>
Print a brief help message and exits.
=item B<-man>
Prints the manual page and exits.
=back
=head1 DESCRIPTION
B<This program> will read the given input file(s) and do something
useful with the contents thereof.
=cut
