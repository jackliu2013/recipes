#!/usr/bin/env perl

#
# 缓存流水文件
#

use Cache::Memcached;
use IO::File;
use Data::Dump;

use strict;
use warnings;

my $memd = new Cache::Memcached {
    'servers'            => [ "127.0.0.1:11211" ],
    'debug'              => 0,
    'compress_threshold' => 10_000,
};

my $rfh = IO::File->new("<0080.src");
my $line = 0;

while(<$rfh>) {
    $line++;
    $memd->set("$line", $_);
}

