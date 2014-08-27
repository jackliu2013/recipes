#!/usr/bin/perl -w

use strict;
use Data::Dump;

## 在平均值之上
sub above_average {

	my $avg = &my_average( @_ );
	my @aret ;
	foreach ( @_ ) {
		if ( $_ > $avg ) {
			push @aret,$_;
		}
	}
		
	return \@aret ;
}


## 计算平均值
sub my_average {
	my $sum = shift @_ ;
	foreach ( @_ ) {
		$sum += $_ ;	
	}
	
	my $average = $sum/@_ ;
	Data::Dump->dump("average is $average");
	return $average ;
}

## 打印在平均值之上的数组的元素
my @arr = (1,2,4,5,6,3);
my $aref = above_average @arr ;
Data::Dump->dump($aref);
