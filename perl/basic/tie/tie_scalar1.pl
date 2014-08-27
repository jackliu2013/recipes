#!/usr/bin/env perl

package Centsible;

=comment
TIESCALAR classname, LIST
     This is the constructor for the class.  That means it is expected
     to return a blessed reference to a new scalar (probably anonymous)
     that it's creating
=cut
sub TIESCALAR { bless \my $self, shift } 

# 做缺省的事情 赋值操作
sub STORE { ${$_[0]} = $_[1]; }      

# 对值进舍入  取值操作
sub FETCH { sprintf "%0.2f", ${my $self = shift } } 


package main;

tie $bucks, 'Centsible' ;

$bucks = 45.00; # $_[0]=$bucks ,  $_[1]=45.00 
$bucks *= 1.0715;  # $_[0]=$bucks , $_[1]=$bucks*1.0715
$bucks *= 1.0715;  # $_[0]=$bucks , $_[1]=$bucks*1.0715
print "That will be $bucks, pleas.\n";


__END__
当把tie $bucks, 'Centsible'; 此行注释后，可以看到区别
