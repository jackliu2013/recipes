#!/usr/bin/env perl

use strict;
use warnings;
use Carp;
use Data::Dump;

use IO::File;
use IO::Socket;
use File::Path qw/mkpath/;
use POSIX ":sys_wait_h";

# server cfg
my $cfg = {
    PeerAddr => '192.168.100.202',
    PeerPort => '11101',
    Proto    => 'tcp',
    cnt      => 3,
    logpath  => '/home/jackliu/log',
    logfile  => 'test.log',
};


my $i=0;
my $pid;
my $stat;
my $msg = 'hello this is a test\n';
my $logpath = $cfg->{logpath};
unless ($logpath) {
    confess "cannot get logpath"
}
unless ( -e $logpath && -e ) {
    mkpath ($logpath);
}
if($@) {
    confess "mkdir $logpath failed";
}

# $SIG{CHLD} = sub {
#     unless (wait(-1, $stat, WNOHANG)) {
#         confess "process child process error";
#     }
#     warn "child process exit success\n";
# };
$SIG{CHLD} = 'IGNORE';

while($i < $cfg->{cnt}) {
    
   # child process
   if (($pid=fork()) == 0) {
        # create socket 
        my $socket = IO::Socket::INET->new(
                PeerAddr => $cfg->{PeerAddr},
                PeerPort => $cfg->{PeerPort},
                Proto    => $cfg->{Proto}) or confess "$@,cannot create socket";
      
        unless($socket->send($msg)) {
            $logpath->print("send data error\n");
            confess "send data error. $@";
        }
        $logpath->print("send data success\n");

        $socket->close();
        $logpath->print("socket close ok\n");
        exit 0;

   }
   elsif ($pid == '-1') {
      confess "fork child process error.$@";
   }

}

exit 0;
