#!/usr/bin/perl

use strict;
use warnings;

my $n;
######define a subroutine########
sub marine {
	$n += 1; #全局变量$n
	print "Hello, sailor number $n!\n";
}

#####call the subroutine###########invocation

&marine ;	#输出Hello,salior number 1!
&marine ;	#输出Hello,salior number 2!
&marine ;	#输出Hello,salior number 3!
&marine ;	#输出Hello,salior number 4!
&marine ;	#输出Hello,salior number 5!
&marine ;	#输出Hello,salior number 6!
