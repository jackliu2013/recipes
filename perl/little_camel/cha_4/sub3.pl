
=t
sub larger_of_fred_or_barney {
	if ($fred > $barney){
		$fred;
	}
	else{
		$barney;
	}
}
=cut


=demo1
sub max{	
#和 &larger_of_fred_or_barney 比较

	if($_[0] > $_[1]){
		$_[0];
	}
	else{
		$_[1];
	}
}
=cut

my @num=qw//;
sub max {
	my $max = shift @_ ;
	foreach (@_){
		$max = $_ if $_ > $max ;
	}
	$max;
}
#$n = &max(10,15,33,2000,1000,3000,90000);
$n = &max();
print "the max value is $n\n";
