#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;

#####################################
#
# 从hash中 delete 一个key/value 对
# 返回  :    被删除的key对应的value
#
# 从hash中 delete 多个key/value 对
# 返回  :    被删除最后一个的key对应的value
#
#####################################

# 定义一个hash
my $thash = {
    a => 'hello world',
    b => 'yeepay',
    c => 'good',
    d => 'bad',
    e => 'ok',
    f => 'sorry',
};

warn "-------before delete--------";
Data::Dump->dump($thash);

warn "-------delete key/value a=>hello world------\n";
my $a = delete $thash->{a};
warn "$a";

warn "-------afher delete--------";
Data::Dump->dump($thash);

my %test;
$test{$a} = "come on yeepay";

Data::Dump->dump( \%test );

$a = delete @{$thash}{qw/c d/};

warn "$a";

#####################################
#
# 从array 中 delete 一个元素
# 返回  :   被删除的元素
#
# 从array 中 delete 多个元素
# 返回  :   被删除的最后一个元素
#
#####################################

my @tarr = qw/hello world 11 22 44/;

my $c = delete $tarr[0];    # return hello
warn "$c";       

$c = delete @tarr[ 1 .. 3]; # return 22
warn "$c";

