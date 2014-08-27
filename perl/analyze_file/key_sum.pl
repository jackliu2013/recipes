use strict;
use warnings;
use Data::Dump;

#my %hData;
my $href;

while(<DATA>){
  chomp;
  my ($sKey, $sValue) = split;
  #$hData{$sKey} = exists $hData{$sKey} ?
  #                $hData{$sKey} + $sValue :
  #                $sValue;
  $href->{$sKey} = exists $href->{$sKey} ?
                  $href->{$sKey} + $sValue :
                  $sValue;
  #if(exists $hData{$sKey}){
  #  $hData{$sKey} += $sValue;
  #}
  #else{
  #  $hData{$sKey} = $sValue;
  #}
}
Data::Dump->dump($href);
__DATA__
a 1
b 2
c 3
a 4
