#!/usr/bin/env perl

use Encode;
use strict;
use warnings;
use Data::Dump;

use utf8;
binmode(STDOUT, ":utf8");

my $dat = "测试文本";
Data::Dump->dump("origin:" .$dat);
warn "origin data: $dat";

# my $str = decode( "gb2312", $dat );
# Data::Dump->dump("gb2312解码:" .$str);
# warn "gb2312解码:" . "$str";
# my @chars = split //, $str;
#foreach my $char (@chars) {
    #print encode( "gb2312", $char ), "\n";
    #print encode( "gb2312", $char ), "\n";
#	warn "gb2312编码:" . "$char" ;
# }
