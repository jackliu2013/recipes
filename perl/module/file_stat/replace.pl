#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use File::stat;
use IO::File;
use Carp;

=comment
bip表有blob字段，每次维护太麻烦，特整理此脚本，结合export.sh import.sh做bip表的数据维护。
1. export.sh 导出bip数据的时候，逐条导出成del文件对对应的lob文件
2. delete.pl 删除没有bip数据的del文件
3. 运行此程序修改del文件中的对lob文件大小的描述(lob文件有修改的时候)
4. import.sh 将修改后的lob文件和del文件导入到bip表

此脚本的思路：
1. 把有数据的文件重定向到allfiles文件
2. 从allfiles文件中逐个遍历del文件及对应的lob文件的大小
3. 生成一个临时文件，把其中的lob文件的字节的大小进行更改
4. 用生成的临时文件覆盖原来的对应的del文件

=cut

my $rfh = IO::File->new("<allfiles");
if ($@) {
    confess "cannot open, errmsg is $@\n";
}

while (<$rfh>) {
    chomp;
    my $ofile = $_ ;

    my $lobfile = './lob/' . $_ . '.001.lob';
    # warn "file is $file\n";
    my $st = stat($lobfile) or die "No $lobfile: $!";
    warn "$lobfile size is $st->[7]\n";

    # 先把更改后的数据写到临时文件
    my $nfile = $_ . 'tmp';
    my $wfh = IO::File->new(">$nfile");
    my $rfh1 = IO::File->new("<$ofile");

    while (<$rfh1>) {
       chomp;
       if (/(^.+lob\.0.)(\d+)(\/.+$)/) {
           my $tmp = $1 . $st->[7] . $3;
           print $wfh "$tmp\n"; 
       }
    }
    $rfh1->close();
    $wfh->close();

    print "--------------$nfile\n";
    system("mv $nfile $ofile");
}

$rfh->close();
