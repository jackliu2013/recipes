use Pod::Usage;
use Getopt::Long;

## Parse options
GetOptions( "help", "man", "flag1" ) || pod2usage( -verbose => 0 );
pod2usage( -verbose => 1 ) if ($opt_help);
pod2usage( -verbose => 2 ) if ($opt_man);

## Check for too many filenames
pod2usage( -verbose => 2, -message => "$0: Too many files given.\n" )
  if ( @ARGV > 1 );
