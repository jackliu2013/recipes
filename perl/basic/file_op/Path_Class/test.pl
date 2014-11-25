#!/usr/bin/env perl
use strict;
use warnings;
use Path::Class;

# recusive find file
my $dir = dir( '/home/jackliu/workspace/recipes/perl/basic/file_op', 'IO_Dir' );    # find all files in directory /home/jackliu/workspace/recipes/perl/basic/file_op/IO_Dir

# Iterate over the content of /home/jackliu/workspace/recipes/perl/basic/file_op/IO_Dir
while ( my $file = $dir->next ) {

    # See if it is a directory and skip
    next if $file->is_dir();

    # Print out the file name and path
    print $file->stringify . "\n";
}
