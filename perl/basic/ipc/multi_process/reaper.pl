#!/usr/bin/evn perl

use strict;
use warnings;

use POSIX ":sys_wait_h";

# 僵尸进程的收割函数
sub REAPER {
    my $child;
    # If a second child dies while in the signal handler caused by the
    # first death, we won't get another signal. So must loop here else
    # we will leave the unreaped child as a zombie. And the next time
    # two children die we get another zombie. And so on.
    while ( ( $child = waitpid( -1, WNOHANG ) ) > 0 ) {
        # 如果子进程成功退出，保存子进程的退出状态
        $Kid_Status{$child} = $?;
    }
    $SIG{CHLD} = \&REAPER;    # still loathe SysV   在waitpid后，继续绑定SIGCHLD的信号处理函数为REAPER 防止有部分僵尸进程不能回收
}
# 绑定SIGCHLD信号的处理函数
$SIG{CHLD} = \&REAPER;

# do something that forks...
