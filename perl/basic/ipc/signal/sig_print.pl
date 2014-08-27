#!/usr/bin/env perl

use strict;
use warnings;

use Config;
use Data::Dump;
# my %signo;
# my @signame;
# my $i=0;

defined( $Config{sig_name} ) || die "No sigs?";
#   foreach my $name ( split( " ", $Config{sig_name} ) ) {
#       $signo{$name} = $i;
#       $signame[$i] = $name;
#       $i++;
#   }
#   
#   
#   Data::Dump->dump(%signo);
#   Data::Dump->dump(@signame);
Data::Dump->dump($Config{sig_name});
