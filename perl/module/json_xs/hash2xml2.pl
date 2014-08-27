#!/usr/bin/env perl

use strict;
use XML::Twig;

=comment
使用XML::Twig模块把perl中的hash 转化成xml
=cut
my $hash = {
    name   => 'bob',
    value1 => 'blah',
    value2 => 'blah2',
};


=comment
my $hash = {
    round => '四舍五入',  # 取整规则: 向上|向下|四舍五入
    gset  => {
        1 => {
            dir => '入',  # 本金方向:  入|出
            in =>{
                acct   => [ '774459222622', ], # 本金划付账号:      '622588210019'
                period => '日',                    # 本金划付周期:      '日|周|月|季度|半年|年|实时',
                nwd    => '否',                    # 非工作日是否划付:  '是|否'
                delay  => 0,                       # 划付延迟,单位(天): '1|2|3|....',
            },            
            rules => [        # 规则数组
                {  
                    ack  => '直接',         # '直接|周期'
                    dir  => '出',           # 手续费方向: '入|出'
                    hf   => {        
                        type    =>  '非财务外付',     # '财务外付|非财务外付'
                        acct    =>  [ '774459222622', ], # '6225882100198883'
                        period  =>  '月',           # '日|周|月|季度|半年|年|实时',
                        nwd     =>  '否',           # '是|否',
                        delay   =>  10               # 单位(天): '1|2|3|4...',
                    },                # 手续费-划付信息
                    sect => [         # 计算区间
                        { 
                            begin   => 0,     # 单位(分)
                            end     => 999999999999999999,    # 单位(分)
                            mode    => '定额',  # '比例|定额'
                            quota   => 100,    # 
                        }, # 区间1
                    ],
                },
            ],
        },
    },
};
=cut

my $twig = XML::Twig->new( pretty_print => 'indented' );

my $elt = create_element( newPhone => $hash );
$twig->set_root($elt);

$twig->print();

sub create_element {
    my $gi   = shift;
    my $data = shift;

    my $t = XML::Twig::Elt->new($gi);

    if ( ref $data ) {
        while ( my ( $k, $v ) = each(%$data) ) {
            create_element( $k, $v )->paste( last_child => $t );
        }
    }
    else {
        $t->set_text($data);
    }

    $t;
}
