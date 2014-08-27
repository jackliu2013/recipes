#!/usr/bin/env perl

use Encode;  
use strict;  

my $a = "china中国";  
my $b = "china中国";  
Encode::_utf8_on($a);  
Encode::_utf8_off($b);  
#$a =~ /W+/;  
#$b =~ /W+/;  
print $a, "\n";  
print $b, "\n"; 
