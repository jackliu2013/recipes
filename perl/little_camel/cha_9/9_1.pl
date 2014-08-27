#!/usr/bin/perl

use strict;
use warnings;

my $_ = "He’s out bowling with Barney tonight.";

s/Barney/Fred/;    #Barney 被 Fred 替换掉

print "$_\n";

$_ = "green scaly dinosaur";
s/(\w+) (\w+)/$2, $1/;    #现在为 “scaly, green dinosaur”
print "$_\n";

s/^/huge, /;              #现在为 “huge, scaly, green dinosaur”
print "$_\n";
s/,.*een//;               #空替换,现在为 “huge dinosaur”
print "$_\n";
s/green/red/;             #匹配失败,仍然为 “huge dinosaur”
print "$_\n";
s/\w+$/($`!)$& /;         #现在为 “huge (huge !)dinosaur”
print "$_\n";
s/\s+(!\W+)/$1 /;        #现在为 "huge (huge!) dinosaur”
print "$_\n";
s/huge/gigantic/;         #现在为 “gigantic (huge!) dinosaur”
print "$_\n";
