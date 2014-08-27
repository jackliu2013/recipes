=standard in
从标准输入设备输入	<STDIN>
=cut
#!/usr/bin/perl

use strict;
use warnings;

=demo1
my $line = <STDIN>;
chomp($line);
print $line,"\n";
=cut

my $line;
while( defined($line = <STDIN>) ){
	print "I saw $line";
}

