=diamond operator<>
<>尖括号输入，是一种特殊的行输入操作，其输入可由用户选择
可能是从键盘，也可能是从文件
=cut

#!/usr/bin/perl

use strict;
use warnings;

my $line;

#while (defined($line = <>)){
#	chomp($line);
#	print "It was $line that I saw!\n";
#}

while(<>){
	chomp;
	print "It was $_ that I saw!\n";
}
