#!/usr/bin/env perl


use strict;
use warnings;
use POSIX ":sys_wait_h";

$SIG{CHLD} = sub {
    print "receive SIGCHLD signal" . "\n";
};

print "before fork, pid:$$\n";  # $$ 当前进程的进程ID
my $kid;
my $pid = fork ;

if ($pid > 0) {
    print "this is parent. $$" . "\n" ;
    do {
       $kid =  waitpid(-1, WNOHANG);        # -1 ：表示等待同一进程组下的任意子进程
                                            # WNOHANG : return immediately if no child has exited.
    }
    until $kid > 0;
    print "the child return status is $?" . "\n";   # $? 进程退出是的状态
}
elsif ( $pid == 0 ) {
    print "this is child. $$, pid:" . getppid() . "\n" ;
    sleep 20;
    exit 0;
}
else {
    print "fork error" . "\n" ;
}

exit 0 ;
