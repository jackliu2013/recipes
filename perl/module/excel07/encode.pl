#!/usr/bin/env perl

use Encode;

use strict;
use warnings;

my $dat="测试文本";
print $dat . "\n";

my $str=decode("utf8", $dat);

# my @chars = split //, $str;
# foreach (@chars) {
#     print encode("utf8", $_) . "\n";
# }

print encode("utf8", $str) . "\n";
