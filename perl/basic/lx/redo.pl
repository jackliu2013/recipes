#!/usr/bin/perl 
use strict;
use warnings;

my $FILE = "aa.txt";
open FH,$FILE or die "Can not open files:$!\n";
while (<FH>) {
	chomp;
	if (s/\\$//) {
		$_ .= <FH>;
		warn $_;
		redo unless eof; # 不超过每个文件的 eof
	}
	# 现在处理 $_
}
