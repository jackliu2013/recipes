#!/usr/bin/env perl

use strict;
use warnings;

use IO::Socket; ##IO::Socket::INET模块是IO::Socket模块的子模块，不用重新use。
use IO::Select; ##该模块和Linux下select()函数实现的功能一致，另扩展更过的功能。可以perldoc查看。

# hash to install IP Port
my %ser_info = (
    "ser_ip"   => "192.168.100.202",
    "ser_port" => "11101",
);

&main();

sub main {
    my $ser_addr = $ser_info{"ser_ip"};
    my $ser_port = $ser_info{"ser_port"};
    ##IO::Socket::INET->new()用于初始化一个socket连接，其中集成了socket、inet_aton、connect、bind、listen等功能。就不需要单独转换IP地址为网络地址结构了，直接使用IP地址就ok了。
    my $socket = IO::Socket::INET->new(
        PeerAddr => "$ser_addr",
        PeerPort => "$ser_port",
        Type     => SOCK_STREAM,
        Proto    => "tcp",
    ) or die "Can not create socket connect.$@";

    $socket->send( "Client Ok!\n", 0 );    ##发送消息至服务器端。
    $socket->autoflush(1);
    # my $sel = IO::Select->new($socket);    ##建立select对象
    # while ( my @ready = $sel->can_read ) { ##等待服务端返回的消息
    #     foreach my $fh (@ready) {
    #         if ( $fh == $socket ) {
    #             while (<$fh>) {
    #                 print $_;
    #             }
    #             $sel->remove($fh);
    #             close $fh;
    #         }
    #     }
    # }
    $socket->close() or die "Close Socket failed.$@";
}
