#!/usr/bin/perl

my $cur_sect;
my %hash;

#
#
#
while(<>) {
   s/^\s+//g;
   s/\s+$//g;
   next if /^$/;

   # [section]
   $cur_sect = $1 and next if /^\[(\w+)]/;

   next unless $cur_sect;

   if ( /(\w+)\s*=\s*(\w+)/ ) {
       $hash{$cur_sect}{$1} = $2;
   }
}

use Data::Dumper;

print Data::Dumper->Dump([\%hash]);
