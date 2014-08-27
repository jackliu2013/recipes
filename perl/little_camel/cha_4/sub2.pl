=tell
许多时候,当调用某个子程序时,需要使用其返回值。这意味着应当注意子程序返回值。所有的 Perl 子程序都会返回值,
在 Perl 中返回值和不返回值是没有区别的。当然,不是所有 Perl 子程序返回的值都是有用的。
由于所有的被调用的子程序都要返回值,因此使用特殊的返回值语法在大多数情况下是一种浪费。因此 Larry 将之简化了。
当 Perl 遍历此子程序时,将会计算每一步的值。此子程序中最后计算的值将被返回
=cut

=demo1
sub sum_of_fred_and_barney{
	print "Hey, you called the sum_of_fred_and_barney suroutine!\n";
	$fred + $barney;	#返回值
}
=cut


##demo2
sub sum_of_fred_and_barney{
	print "Hey, you called the sum_of_fred_and_barney suroutine!\n";
	$fred + $barney;	#返回值
	print "Hey, I'm returning a value now!\n";
}


$fred = 3;
$barney = 4;
$wilma = &sum_of_fred_and_barney; # demo1 $wilma=7 ,demo2 $wilma=1
print "\$wilma is $wilma\n" ; 
$betty = 3 * &sum_of_fred_and_barney; 
print "\$betty is $betty\n";

