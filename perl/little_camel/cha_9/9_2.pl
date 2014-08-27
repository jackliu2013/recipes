#!/usr/bin/perl

use strict;
use warnings;

my @fields = split /:/, "abc:def:g:h"; #返回(“abc”,“def”,“g”,“h”)
print @fields,"\n";
