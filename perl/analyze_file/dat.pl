#!/usr/bin/perl

use strict;
use warnings;
use Data::Dump;

my $href;
##<DATA> __END__ 说明DATA是__END__后面的数据
while (<DATA>) {

    #去掉行首行尾的空格
    s/^\s+|\s+$//g;

    #跳过空行
    next if /^$/;

    my ( $who, @dat ) = split;

    #Data::Dump->dump($who);
    #Data::Dump->dump(@dat);

    for (@dat) {

        # 处理XXX_x=9999
        next unless /(\w+)\_(\w+)\=(\d+)/;

        ${ $href->{$who}->{$1} }{$2} += $3;

        #Data::Dump->dump(${$href->{$who}->{$1}}{$2});
    }

}

Data::Dump->dump($href);

__END__
A	BUS_x=1  BUS_y=2  BUS_z=3  BUS_t=1
B	BUS_x=1  BUS_y=2  BUS_z=3
A	BUS_x=1  BUS_y=2  BUS_z=3
