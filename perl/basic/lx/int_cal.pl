#!/usr/bin/env perl

use strict;
use warnings;

# my $total = 10003 ;
my $total = 10005 ;
# my $total = 3 ;
my $size = int( $total / 5 );    # 单个文件大小
my $res = $total % 5;              # 最后一个文件大小
my $cnt;
if ( $size == 0 ) {
    $cnt  = 0;
    $size = $res;
}
else {
    $cnt = int( $total / $size );
}
warn "total: $total, size: $size, res: $res, cnt: $cnt"
