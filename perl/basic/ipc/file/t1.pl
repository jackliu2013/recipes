#!/usr/bin/env perl

use warnings;
use strict;
use Fcntl qw/:DEFAULT :flock/;

# 打开文件aa , 从文件中读数据
open( FH, "< aa" ) or die "Can't open aa: $!";
# 对文件aa 添加共享锁
flock( FH, LOCK_SH ) or die "Can't lock aa: $!";
print "got it.\n";
