=help
此脚本需要传递一个参数
=cut
#!/usr/bin/perl
use strict;
use warnings;

my $tarname="package.tar.gz";
my @file=();
while (<>){
	s/^\s+//g;
	s/\s+$//g;
	next if /^$/;
	push @file,$_;
}
print "@file\n";
system("tar zcvf $tarname @file");
