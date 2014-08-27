#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;

my ( $name, $path, $suffix );

my $fullname = '/home/jackliu/t.pl' ;

# 文件名后缀的正则匹配 
# .打头，后面有0或多个字符
my @suffixlist = qr/\.[^.]*/;

# 
( $name, $path, $suffix ) = fileparse( $fullname, @suffixlist ); 
warn " name is $name\n path is $path\n suffix is $suffix\n";

# 
( $name, $path, $suffix ) = fileparse( $fullname );
warn " name is $name\n path is $path\n";

#
$name = fileparse( $fullname, @suffixlist );
warn " name is $name\n";


my $basename = basename( $fullname, @suffixlist );
warn "basename is $basename\n";
# $dirname = dirname($fullname);
