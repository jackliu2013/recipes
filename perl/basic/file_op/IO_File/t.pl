#!/usr/bin/env perl

# 测试IO::File

use strict;
use warnings;

use IO::File;

# 从file读取数据
my $fh = IO::File->new();
if ( $fh->open("< file") ) {
    print <$fh>;
    $fh->close;
}

# $fh = IO::File->new("> file");
# if ( defined $fh ) {
#     print $fh "bar\n";
#     $fh->close;
# }

# $fh = IO::File->new( "file", "r" );
# if ( defined $fh ) {
#     print <$fh>;
#     undef $fh;    # automatically closes the file
# }

# $fh = IO::File->new( "file", O_WRONLY | O_APPEND );
# if ( defined $fh ) {
#     print $fh "corge\n";
# 
#     $pos = $fh->getpos;
#     $fh->setpos($pos);
# 
#     undef $fh;    # automatically closes the file
# }

