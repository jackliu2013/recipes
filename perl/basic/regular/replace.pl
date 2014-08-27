#!/usr/bin/env perl

=comment
对aa.txt中的匹配hello的字符串进行转换为大写
1. 先定义一个写的临时文件，进行文字转换，然后进行替换操作
2. 临时文件修改为原文件
=cut

use strict;
use warnings;

use IO::File;

my $rfh = IO::File->new("<aa.txt");
my $wfh = IO::File->new(">ab.txt");

while (<$rfh>) {
    chomp;
    if (/hello/) {
        s/hello/\U$&/g;
        print $wfh "$_\n";
    }
}

$wfh->close();
$rfh->close();

system("mv ab.txt aa.txt");
