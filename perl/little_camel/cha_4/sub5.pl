=tell
返回操作将立刻的从子程序中返回一个值:
=cut
#!/usr/bin/perl

use strict;
use warnings;

my @names = qw /fred barney betty dino Wilma pebbles bam-bamm/;
my $result = &which_element_is("dino", @names);
print $result;
sub which_element_is{
	my($what, @array) = @_;
	foreach(0..$#array){	 #	@array 元素的索引 ,$#array是@array的最大索引
		if($what eq $array[$_]){
			return $_;	#找到既返回,返回索引值
		}
	}
	-1;	#没有找到元素(此处是可选的)
}
