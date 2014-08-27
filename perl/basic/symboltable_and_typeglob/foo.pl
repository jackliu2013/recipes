#!/usr/bin/env perl

=comment

查看软件包的所有符号

=cut


package Foo;

# demo1
# 在未定义变量和函数前，打印软件包的符号表
# 在未定义变量和sub函数前，软件包Foo的符号表是空的
#
#print "-------without define vars and subs----------------\n";
#foreach my $entry ( keys %Foo:: ) {
#    print "$entry\n";    
#}


# demo2
# 在定义了变量和函数后，打印软件包的符号表
# 定义 三个变量和一个sub函数 符号
#
#print "-------with define vars and subs----------------\n";
#@n      = 1 .. 5;
#$string = 'hello world!';
#%dict   = ( 1 => 'one' );

#sub add { $_[0] + $_[1] ;}

#foreach my $entry ( keys %Foo:: ) {
#    print "$entry\n";    
#}


# demo3 
# 在定义变量和函数后，打印定义的变量的类型
#
#
print "------print vars type and sub--------\n";

@n      = 1 .. 5;
$string = 'hello world!';
%dict   = ( 1 => 'one' );

sub add { $_[0] + $_[1] ;}

foreach my $entry ( keys %Foo:: ) {
    print '-' x 30, "Name: $entry\n";

    print "\tscalar is defined\n" if defined ${$entry};
    print "\tarray  is defined\n" if defined @{$entry};
    print "\thash   is defined\n" if defined %{$entry};
    print "\tsub    is defined\n" if defined &{$entry};
}
