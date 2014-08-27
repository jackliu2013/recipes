#!/usr/bin/env perl
use strict;
use warnings;

use Pod::Usage;
my $message_text = "This text precedes the usage message.";
my $exit_status   = 2;           ## The exit status to use
my $verbose_level = 0;           ## The verbose level to use
my $filehandle    = \*STDERR;    ## The filehandle to write to

#pod2usage($message_text);

#pod2usage($exit_status);

#pod2usage(
#    {
#        -message => $message_text,
#        -exitval => $exit_status,
#        -verbose => $verbose_level,
#        -output  => $filehandle
#    }
#);


#pod2usage(
#    -msg     => $message_text,
#    -exitval => $exit_status,
#    -verbose => $verbose_level,
#    -output  => $filehandle
#);


pod2usage(
    -verbose   => 2,
    -noperldoc => 1
  )
