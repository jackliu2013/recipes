#!/usr/bin/perl -w
use strict;

use Data::Dump;

my %hash=(
	a => '1',
	b => '2',
	d => '',
	c => );
Data::Dump->dump(\%hash);

########删除hash中value未定义的key/value对
for ( keys %hash ) {
    delete $hash{$_} unless defined $hash{$_};
}

Data::Dump->dump(\%hash);
