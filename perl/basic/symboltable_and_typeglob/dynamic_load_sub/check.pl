#!/usr/bin/env perl

use strict;
use warnings;

# 
# 检查一个数值的子程序
# is_defined 检查是否定义 
# not_empty  检查是否空值 
# is_long    检查长度
# has_whitespaces 检查有空格
# no_whitespaces 检查无空格
# has_digit      检查有数字
# only_digits    检查无数字
# has_special    检查有无特殊字符
#
my %check = (
    is_defined      => sub { defined $_[0] },
    not_empty       => sub { length $_[0] > 0 },
    is_long         => sub { length $_[0] > 0 },
    has_whitespaces => sub { $_[0] =~ /\s/ },
    no_whitespaces  => sub { $_[0] !~ /\s/ },
    has_digit       => sub { $_[0] =~ /\d/ }, 
    only_digits     => sub { $_[0] !~ /\D/ },
    has_special     => sub { $_[0] =~ /[^a-z0-9]/ },
);


#
# 检查一个密码，要求密码至少8个字符，没有空格，
# 至少一个数字和一个特殊字符
#
my $password = <STDIN>;
chomp($password);
my $fails = grep { ! $check{$_}->($password) } qw/is_long no_whitespaces has_digit has_special/;

if ( $fails ) {
    print "password is error\n";
    exit 1;
}
print "password is ok\n";

#my $tmp = 'tmp22';
#
#print "\$tmp value is $tmp\n\n";
#
#if ( $check{is_defined}->($tmp)  ) {
#    print "\$tmp is defined\n";
#}
#if ( $check{not_empty}->($tmp) ) {
#    print "\$tmp is not_empty\n";
#}
#if ( $check{is_long}->($tmp) ) {
#    print "\$tmp is long\n";
#}
#if ( $check{has_whitespaces}->($tmp) ) {
#    print "\$tmp has whitespaces\n";
#}
#if ( $check{no_whitespaces}->($tmp) ) {
#    print "\$tmp without whitespaces\n";
#}
#if ( $check{has_digit}->($tmp) ) {
#    print "\$tmp has digit\n";
#}
#if ( $check{only_digits}->($tmp) ) {
#    print "\$tmp only digits\n";
#}
#if ( $check{has_special}->($tmp) ) {
#    print "\$tmp has special\n";
#}
