#!/usr/bin/perl

my $name;
while(<>){
	s/^\s+//g;	#删除行首空格
	s/\s+$//g;	#删除行尾空格
	next if /^$/ ;	#跳过空行
	$name = $_ ;
	print "[$name]\n"
}

