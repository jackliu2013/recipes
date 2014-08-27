#!/usr/bin/perl

=splittest
while(<>){
	my ($id,$name) = split ;
	print "$id,$name\n";
}
=cut



my @list = qw/2013000000000001 2013040210210001 1 123986323.33 892384932.22 0012211212121212 2013-04-02 10:38:10.817154 8243028.22 98989.99 2013-04-02 10:38:10.817154/;

my @hello = split "\s+", @list;
warn @hello;


my $lo =join "|",(split "\s+", @list);
warn $lo;
