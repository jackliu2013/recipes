#!/usr/bin/perl
use strict;

my $key  = 'welcome';
my %data = (
    'this'    => qw(that),
    'tom'     => qw(and jerry),
    'welcome' => q(Hello World),
    'zip'     => q(welcome),
);
my @data = keys %data;

print "$data{$key}\n";
exit;
