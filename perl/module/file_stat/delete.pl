#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use File::stat;
use IO::File;
use Carp;

my $rfh = IO::File->new("<allfiles");
if ($@) {
    confess "cannot open, errmsg is $@\n";
}

while (<$rfh>) {
    chomp;
    my $file = $_;
    my $st = stat($file) or die "No $file: $!";
    # warn "$file size is $st->[7]\n";

    # 删除没有数据的文件
    unless ($st->[7]) {
        warn "file is $file\n";
        system("rm $file");
    }
}

$rfh->close();
