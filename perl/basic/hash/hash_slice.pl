#!/usr/bin/perl

use strict;
use warnings;

=p
my %h = ( a => 7, b => 8, c => 9 );

my @l = qw(a b c);

my @a = @h{ @l
  }; # -- when put array in hash's iterator and put the '@' at ahead of the hash varaible，it means produce a array from hash：naming hash slice"
print @a, "\n";
=cut

#example1====
my %hash = (
    'one' => {
        'first'  => 1,
        'second' => 2,
    },
    'two' => {
        'third'  => 3,
        'fourth' => 4,
    }
);

my $key = 'one';
my @list = ( 'first', 'second' );

## 用到hash slice
print $_ . " " for @{ $hash{$key} }{@list};    #print 1 2
print "\n";

#example2====

my $foo = { a => 4, b => 5, c => 6 };
my $href = $foo;

my %bar = ( foo => $href );                    # foo is now a reference in %bar
print @{ $bar{foo} }{ 'a', 'b' }, "\n";
print ${ $bar{foo} }{'a'}, "\n";
print ${ $bar{foo} }{'b'}, "\n";
###通过引用和箭头来访问数据
print $bar{foo}->{'a'}, "\n";
print $bar{foo}->{'b'}, "\n";

#example3====
no strict "refs";
$foo = { a => 4, b => 5, c => 6 };
$href = $foo;
my @arr = keys %$foo ;
warn "keys:@arr";


$foo = { a => 4, b => 5, c => 6 };
print "$foo->{a}\n";

my %foo = ( a => 4, b => 5, c => 6 );
print "$foo{a}\n";
