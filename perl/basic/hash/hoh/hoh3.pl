#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

my %TV = (
    flintstones => {
        series  => "flintstones",
        nights  => [qw/monday thursday friday/],
        members => [
            { name => "fred",    role => "lead", age => 36, },
            { name => "wilma",   role => "wife", age => 31, },
            { name => "pebbles", role => "kid",  age => 4, },
        ],
    },

    jetsons => {
        series  => "jetsons",
        nights  => [qw/wednesday saturday/],
        members => [
            { name => "george", role => "lead", age => 41, },
            { name => "jane",   role => "wife", age => 39, },
            { name => "elroy",  role => "kid",  age => 9, },
        ],
    },

    simpsons => {
        series  => "simpsons",
        nights  => [qw/monday/],
        members => [
            { name => "homer", role => "lead", age => 34, },
            { name => "marge", role => "wife", age => 37, },
            { name => "bart",  role => "kid",  age => 11, },
        ],
    },

);

#
# 访问key:flintstones的 key:nights里的第一个元素
#
my $href = $TV{flintstones} ;
print "$TV{flintstones}->{nights}->[0]\n";
print "$href->{nights}->[0]\n";

print "$href->{members}->[0]->{name}\t";
print "$href->{members}->[0]->{role}\t";
print "$href->{members}->[0]->{age}\n";


no strict 'refs' ;
warn "-----------------";
$href = \%TV ;
print "$href->{jetsons}{series}\n";
print "$href->{jetsons}->{series}\n";

