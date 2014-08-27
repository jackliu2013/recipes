#!/usr/bin/env perl

=comment

使用JSON::XS
把perl中的hash转换成json

把hash的银行协议转换成json 
=cut

use strict;
use warnings;

use JSON::XS;
use Getopt::Long;
use Encode;
use Data::Dump;
use utf8;
binmode( STDOUT, ':utf8' );


#my $fname = '';
#my $result = GetOptions("filename=s"    => \$fname);
#unless ($result) {
#    &usage;
#}
#unless ($fname) {
#    &usage;
#}

my $href = {
    round => '四舍五入',  # 取整规则: 向上|向下|四舍五入
    gset  => {
        1 => {
            dir => '入',  # 本金方向:  入|出
            in  => {
                acct   => [ '01091022900120105016860', ], # 本金划付账号:      '622588210019'
                period => '日',                    # 本金划付周期:      '日|周|月|季度|半年|年|实时',
                nwd    => '是',                    # 非工作日是否划付:  '是|否'
                delay  => 0,                       # 划付延迟,单位(天): '1|2|3|....',
            },
            rules => [        # 规则数组
                {  
                    ack  => '直接',         # '直接|周期'
                    dir  => '出',           # 手续费方向: '入|出'
                    hf   => {        
                        type    =>  '非财务外付',     # '财务外付|非财务外付'
                        acct    =>  [ '01091022900120105016860', ], # '6225882100198883'
                        period  =>  '日',           # '日|周|月|季度|半年|年|实时',
                        nwd     =>  '是',           # '是|否',
                        delay   =>  0               # 单位(天): '1|2|3|4...',
                    },                # 手续费-划付信息
                    sect => [         # 计算区间
                        { 
                            begin   => 0,     # 单位(分)
                            end     => 999999999999999999,    # 单位(分)
                            mode    => '比例',  # '比例|定额'
                            ratio   => 3000,    # 百万分之
                        }, # 区间1
                    ],
                },
            ],
        },
        2 => {
            dir => '出',  # 本金方向:  入|出
            out => {
            acct   => [ '01091022900120105016860', ], # 本金划付账号:      '622588210019'
            period => '日',                    # 本金划付周期:      '日|周|月|季度|半年|年|实时',
            nwd    => '是',                    # 非工作日是否划付:  '是|否'
            delay  => 0,                       # 划付延迟,单位(天): '1|2|3|....',
            },             
            rules => [        # 规则数组
                {  
                    ack  => '直接',         # '直接|周期'
                    dir  => '入',           # 手续费方向: '入|出'
                    hf   => {        
                        type    =>  '非财务外付',     # '财务外付|非财务外付'
                        acct    =>  [ '01091022900120105016860', ], # '6225882100198883'
                        period  =>  '日',           # '日|周|月|季度|半年|年|实时',
                        nwd     =>  '是',           # '是|否',
                        delay   =>  0               # 单位(天): '1|2|3|4...',
                    },                # 手续费-划付信息
                    sect => [         # 计算区间
                        { 
                            begin   => 0,     # 单位(分)
                            end     => 999999999999999999,    # 单位(分)
                            mode    => '比例',  # '比例|定额'
                            ratio   => 0,    # 百万分之
                        }, # 区间1
                    ],
                },
            ],
        },
    },
};

my $json = JSON::XS->new->utf8->encode($href);

warn "$json";

#sub usage {
#    print "useage: ./json2.pl -f filename" . "\n";
#    exit(1);
#}
